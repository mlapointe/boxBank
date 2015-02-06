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
require 'sass/plugin/rack'



class ApplicationController < Sinatra::Base

  helpers ApplicationHelpers

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
end
