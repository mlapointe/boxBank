class ReviewController < ApplicationController


  get '/' do

    if !authenticated?
      authenticate!
    else
      folder_id = request['folder_id']
      name = request['folder_name']

      client = getBoxClient()
      items = client.folder_items(folder_id)
      collabs = client.folder_collaborations(folder_id)
      dl_links = []

      for file in items
        file_dl = client.download_file(file.id, follow_redirect: false)
        dl_links.push(file_dl)
      end

      erb :review_application, :locals => {items: items, collabs: collabs, name: name, dl_links: dl_links}
    end
  end


  ## Load file in Viewer --> Implement later
  # post '/ajax-getfile' do
  #   file_id = request['file_id']
  #   client = getBoxClient()
  #   file_dl = client.download_file(file_id, follow_redirect: false)
  #
  #   #post to Box View API
  #   headers = {authorization: "Token "+ENV['BOX_VIEW_KEY'], content_type: "application/json" }
  #   params = {url: file_dl}.to_json
  #
  #   RestClient.post('https://view-api.box.com/1/documents', params, headers ){ |response, request, result, &block|
  #     logger.info("request = " + request.headers.to_s)
  #     logger.info("viewAPI response = " + response.body)
  #     res = JSON.parse(response.body)
  #
  #     getSession(res['id'])
  #
  #
  #   }
  #
  # end
  #
  #
  # def getSession(doc_id)
  #
  #   headersesh = {authorization: "Token "+ENV['BOX_VIEW_KEY'], content_type: "application/json" }
  #   session_params = {document_id: " "+doc_id}.to_json
  #   logger.info(session_params)
  #
  #   RestClient.post('https://view-api.box.com/1/sessions', session_params, headersesh ){ |response, request, result, &block|
  #     logger.info("viewAPISesh response = " + response.body)
  #     res = JSON.parse(response.body)
  #
  #     if response.code == 201 #Success
  #       return res
  #     elsif response.code == 202 #Retry-After
  #       time = response.headers['Retry-After']
  #       logger.info("Session not ready. Retry in: "+time)
  #
  #       sleep(time)
  #       getSession(doc_id)
  #     elsif response.code == 400 #Error
  #       logger.info("Error = "+response.body)
  #       return res
  #     else
  #       logger.info("Something else happened....")
  #     end
  #
  #   }
  #
  # end

end
