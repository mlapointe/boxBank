class HomeController < ApplicationController
#  helpers WebsiteHelpers

  get '/' do
    erb :index
  end


end
