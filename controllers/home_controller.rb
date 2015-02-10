class HomeController < ApplicationController
#  helpers WebsiteHelpers

  use Rack::Session::Pool, :cookie_only => false

  def authenticated?
    session[:access_token]
  end


  def authenticate!

    access_token_params = {
      response_type: 'code',
      client_id: 'dnm2os2fyxu0ex7kke6kosfga4vwrczl',
      redirect_uri: 'http://localhost:9292/oauthcallback',
      state: 'test'
    }

    auth_url = 'https://app.box.com/api/oauth2/authorize?' + QueryParams.encode(access_token_params)

    erb :index, :locals => {:auth_url => auth_url}
  end


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

    logger.info("code = " + code)

    error = params[:error]
    error_desc = params[:error_description]


    get_token_params = {
      code: code,
      client_id: 'dnm2os2fyxu0ex7kke6kosfga4vwrczl',
      client_secret: 'qYYu6XllZVHZUNaYF7eKcqdO6rHVD7v6',
      grant_type: 'authorization_code'
    }


    RestClient.post('https://app.box.com/api/oauth2/token', get_token_params ){ |response, request, result, &block|

      logger.info(request)

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
    redirect '/'
  end

end
