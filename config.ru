require 'sinatra/base'

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }


run ApplicationController

map('/apply') { run ClientController }
map('/') { run HomeController }
