require 'sinatra/base'

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

map('/review') { run ReviewController }
map('/apply') { run ClientController }
map('/') { run HomeController }
