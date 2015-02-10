class ReviewController < ApplicationController


  get '/' do
    folder_id = request['folder_id']
    name = request['folder_name']

    client = getBoxClient()
    items = client.folder_items(folder_id)
    collabs = client.folder_collaborations(folder_id)



    erb :review_application, :locals => {items: items, collabs: collabs, name: name}

  end

  get '/file' do


  end


end
