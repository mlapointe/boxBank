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

  post '/upload' do


    logger.info(request['file_path'])


  end




end
