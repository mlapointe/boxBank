$:.unshift(File.expand_path('../../lib', __FILE__))

require "bundler/setup"
require 'sinatra/base'
require 'sinatra/static_assets'
require 'dotenv'
Dotenv.load

require 'queryparams'
require 'rest-client'
require 'json'
require 'sass'
require 'boxr'
require "better_errors"
require 'sass/plugin/rack'
require 'sinatra/form_helpers'
require 'tempfile'
require "base64"
require 'pathname'


class ApplicationController < Sinatra::Base

  helpers ApplicationHelpers
  helpers Sinatra::FormHelpers


  set :root, File.expand_path('../../', __FILE__)
  set :views, File.expand_path('../../views', __FILE__)
  enable :sessions, :method_override, :logging, :static


  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  end

  # use scss for stylesheets
  Sass::Plugin.options[:style] = :compressed
  use Sass::Plugin::Rack

  register Sinatra::StaticAssets

  # register Sinatra::Auth
  # register Sinatra::Contact
  # register Sinatra::Flash
  register

  #use AssetHandler

  # not_found{ slim :not_found }

  def authenticated?
    session[:access_token]
  end


  def authenticate!

    access_token_params = {
      response_type: 'code',
      client_id: ENV['BOX_CLIENT_ID'],
      redirect_uri: 'http://localhost:9292/oauthcallback',
      state: 'test'
    }

    auth_url = 'https://app.box.com/api/oauth2/authorize?' + QueryParams.encode(access_token_params)

    erb :index, :locals => {:auth_url => auth_url}
  end
end
