class ClientController < ApplicationController
  #helpers WebsiteHelpers

  get '/' do
    erb :apply
  end

  post '/submit' do

    client = getBoxClient()

    if client != nil
      #execute
      logger.info("client is there!")

    else
      logger.info("client is nil")
    end


    #Create Shared Folder
    time = Time.now

    topfoldername = "BankOfAmerica-Loans"
    begin
      topfolder = client.folder_from_path(topfoldername)
    rescue Boxr::BoxrException => e

      logger.info("Boxr Exception - no folder: " + e.boxr_message)
      logger.info("Creating new folder:" + topfoldername)

      topfolder = client.create_folder(topfoldername, Boxr::ROOT)

    end

    foldername = "BofA-LoanApp-"+time.strftime("%Y%m%d-%H:%M")
    folder = client.create_folder(foldername, topfolder.id)



    #Add specified files
    for file_id in request["file_ids"] do
      file = client.file_from_id(file_id)
      client.update_file(file, parent_id: folder.id)

      logger.info("Added file with ID #{file_id} to folder #{folder.id}")
    end


    #Add Shared collab permissions w/ bankerselect ID
    #banker = client.user_from_id(request["bankerselect"])
    user_hash = { "id" => request["bankerselect"], "type" => "user" }
    client.add_collaboration(folder, user_hash, "viewer")

    erb :app_submitted,  :locals => {:folder => foldername}

  end


  post '/ajax-getfolder' do

    folder_id = request['folder_id']

    client = getBoxClient()
    items = client.folder_items(folder_id)

    logger.info(items)

    return items.to_json

  end

  post '/upload' do

   data = request['data']
   filename = request['filename']


   ## Decode the file
   data_index = data.index('base64') + 7
   filedata = data.slice(data_index, data.length)
   decoded_file = Base64.decode64(filedata)

   ext = /\.[0-9a-z]+$/.match(filename)

   ## Write the file to the system
   file = Tempfile.new([filename, ext[0]])
   file.write(decoded_file)

   logger.info("Writing #{file.path} to Box")

   #upload to Box
   client = getBoxClient()
   client.upload_file(file, Boxr::ROOT)

  #  box_file_name = /^\\(.+\\)*(.+)\.(.+)$/.match(file.path)

   pn = Pathname.new(file.path)
   box_file_name = pn.basename.to_s

   logger.info(box_file_name)

   file.close
   file.unlink #Delete TempFile

   box_file = client.file_from_path(box_file_name)

   return {'file_id' => box_file.id, 'file_name' => box_file.name}.to_json

  end




end
