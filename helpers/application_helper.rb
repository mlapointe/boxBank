module ApplicationHelpers

  def getBoxClient()

    access_token = session[:access_token]
    refresh_token = session[:refresh_token]

    begin
      client = Boxr::Client.new(access_token, refresh_token: refresh_token)
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

  ## Insecure! -- For demo purposes only
  def isAdmin?
    if session[:admin] == 'admin'
      return true
    elsif session[:admin] == 'client'
      return false
    else
      return false
    end

  end

end
