class HomeController < ApplicationController
#  helpers WebsiteHelpers

  use Rack::Session::Pool, :cookie_only => false



  get '/' do

    if !authenticated?
      authenticate!
    else

       client = getBoxClient()

      topfoldername = "BankOfAmerica-Loans"
      begin
        topfolder = client.folder_from_path(topfoldername)
      rescue Boxr::BoxrException => e
        topfolder = nil

        #logger.info("Boxr Exception - no folder: " + e.boxr_message)
      end

      applications = nil
      if topfolder != nil
        applications =  client.folder_items(topfolder.id)
      end


      #Request succeeded - Box is authenticated
      erb :applications, :locals => {:apps => applications}
    end
  end


  get '/oauthcallback' do
    # session_code = request.env['rack.request.query_hash']['code']

    code = params[:code]
    state = params[:state]
    logger.info("State = "+state)
    if state == "admin"
      logger.info("Admin logged in")
      session[:admin] = "admin"
    else
      session[:admin] = "client"
    end

    logger.info("code = " + code)

    error = params[:error]
    error_desc = params[:error_description]


    get_token_params = {
      code: code,
      client_id: ENV['BOX_CLIENT_ID'],
      client_secret: ENV['BOX_CLIENT_SECRET'],
      grant_type: 'authorization_code'
    }


    RestClient.post('https://app.box.com/api/oauth2/token', get_token_params ){ |response, request, result, &block|

      logger.info("string = " + response.body)
      res = JSON.parse(response.body)
      # set_box_client(res['access_token'], res['refresh_token'])

      session[:access_token] = res['access_token']
      session[:refresh_token] = res['refresh_token']

    }

    redirect '/'
  end


  get '/logout' do
    session[:access_token] = nil
    session[:refresh_token] = nil
    session[:admin] = nil

    redirect '/'
  end

end
