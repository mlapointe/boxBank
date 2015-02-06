$:.unshift(File.expand_path('../../lib', __FILE__))

require "bundler/setup"
require 'sinatra/base'
require 'sinatra/static_assets'
require 'queryparams'
require 'rest-client'
require 'json'
require 'sass'
require 'boxr'
require "better_errors"


class ApplicationController < Sinatra::Base

  helpers ApplicationHelpers

  set :views, File.expand_path('../../views', __FILE__)
  enable :sessions, :method_override, :logging


  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  end

  register Sinatra::StaticAssets

  # register Sinatra::Auth
  # register Sinatra::Contact
  # register Sinatra::Flash
  register

  #use AssetHandler

  # not_found{ slim :not_found }
end
