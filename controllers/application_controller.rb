$:.unshift(File.expand_path('../../lib', __FILE__))

require "bundler/setup"
require 'sinatra/base'
require 'sinatra/static_assets'
require 'queryparams'
require 'rest-client'
require 'json'
require 'sass'

class ApplicationController < Sinatra::Base

  helpers ApplicationHelpers

  set :views, File.expand_path('../../views', __FILE__)
  enable :sessions, :method_override, :logging

  register Sinatra::StaticAssets



  # register Sinatra::Auth
  # register Sinatra::Contact
  # register Sinatra::Flash
  register

  #use AssetHandler

  # not_found{ slim :not_found }
end
