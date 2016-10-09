class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    # @user = User.from_omniauth(request.env["omniauth.auth"])
    @user = User.find_for_oauth(env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
 
  def facebook
    @user = User.find_for_oauth(env["omniauth.auth"], current_user)
    # Chequea que nuestro usuario se haya guardado en la base de datos y no sea una instancia superficial
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      #render :json @user
      set_flash_message(:notice, :success, kind: "facebook".capitalize) if is_navigational_format?
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end