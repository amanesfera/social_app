class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
     auth=request.env["omniauth.auth"]
     # render :plain => auth.inspect
     uid=auth.uid
      expire=auth["credentials"]["expires_at"]
     access_token=auth["credentials"]["token"]
     refresh_token=auth["credentials"]["refresh_token"]

     user_social=Identity.new(:uid=>uid,:provider=>"google_oauth2",:access_token=>access_token,:refresh_token=>refresh_token ,:expire=>expire,:user_id=>current_user.id.to_s)
     if user_social.save
     redirect_to root_path
    else
 	    render :plain => user_social.errors.messages.inspect
    end
     
  end
  def linkedin

  end
end
