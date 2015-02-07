module ApplicationHelpers
  # def css(*stylesheets)
  #     stylesheets.map do |stylesheet|
  #       "<link href="/#{stylesheet}.css" media="screen, projection" rel="stylesheet" />"
  #   end.join
  # end

 # def current?(path='/')
 #   request.path_info==path ? "current": nil
 # end

  def getBoxClient()

    access_token = session[:access_token]

    begin
      client = Boxr::Client.new(access_token)
    rescue Boxr::BoxrException => e

      logger.info("GOT TO Exeption")
      session[:access_token] = nil
      return authenticate!
    else
      if client == nil
        # request didn't succeed because the token was revoked so we
        # invalidate the token stored in the session and render the
        # index page so that the user can start the OAuth flow again

        session[:access_token] = nil
        return authenticate!
      end
    end

    return client
  end
end
