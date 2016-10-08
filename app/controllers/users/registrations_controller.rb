require 'rest_client'

class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  prepend_before_filter :require_no_authentication, :only => [ :get ]
  skip_before_action :ask_loged, only: [ :create, :social ]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    if BannedUser.find_by_email(params[:user][:email])
      render json: {error: "No se puede crear una cuenta con el email '#{params[:user][:email]}', ya que este esta baneado"}, status: 401
    elsif current_user == nil
      #super
      build_resource(sign_up_params)
      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          if User.count == 1
            current_user.admin = true
          else
            current_user.admin = false
          end
          current_user.save
          #respond_with resource, location: after_sign_up_path_for(resource)
          respond_to do |format|
            format.json { render json: {created: current_user} }
            format.html { respond_with resource, location: after_sign_up_path_for(resource) }
          end
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          #respond_with resource, location: after_inactive_sign_up_path_for(resource)
          respond_to do |format|
            format.json { render json: {error: 'Tiempo de registro expirado'}, status: 408 }
            format.html { respond_with resource, location: after_inactive_sign_up_path_for(resource) }
          end
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        #respond_with resource
        @error = ''
        if /.+@.+\..+/.match(params['user']['email']) == nil
          @error = 'El formato del email es incorrecto.'
        else
          if User.find_by_email(params['user']['email']) != nil
            @error = 'El email ya existe en nuestros registros.'
          else
            @error = 'El password debe poseer más de 8 caracteres.'
          end
        end
        respond_to do |format|
          format.json { render json: { error: @error}, status: 400 }
          format.html { respond_with resource }
        end
      end
    else
      render json: {error: "Ya estas logeado como '#{current_user.email}'."}
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  def user_edit
    if current_user == nil
      render json: {error: 'No estas logeado.'}, status: 401
    else
      if current_user.update(account_update_params)
        current_user.avatar_file_name = URI.join(request.url, current_user.avatar.url).path
        render json: {edited: current_user}
      elsif params[:user][:avatar].original_filename.split(".")[1]==nil # si el archivo no tiene extencion
        render json: {error: 'Error, el archivo no posee un formato valido. (Posee extencion nula)'}, status: 400
      else
        render json: {error: 'Error, el archivo no posee un formato valido.'}, status: 403
        # render json: {error: 'Permisos insuficientes'}, status: 403
      end
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  def users
    if current_user.admin == true
      @users = User.order("email ASC").paginate(page: params[:page])
      @users.each do |user|
        user.avatar_file_name = URI.join(request.url, user.avatar.url).path
      end
      respond_to do |format|
        format.json { render json: @users }
        format.html {  }
      end
    else
      respond_to do |format|
        format.json { render json: {error: 'Permisos insuficientes.'} }
        format.html { redirect_to root_path, notice: 'Permisos insuficientes.' }
      end
    end
  end

  def user
    @user = User.find_by_id(params[:id])
    families = @user.families
    respond_to do |format|
      format.json { render json: { user: @user, family: families } }
      format.html {  }
    end
  end

  def user_delete
    if current_user.id == params[:id].to_i or current_user.admin == true
      @user = User.where(id: params[:id])
      if @user == []
        render json: {error: 'Usuario inexistente.'}, status: 404
      elsif User.delete(params[:id])
        render json: {success: 'Eliminacion exitosa.'}
      else
        render json: {error: 'Problema de eliminación.'}, status: 401
      end
    else
      render json: {error: 'No posees los permisos para eliminar este usuario.'}, status: 403
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def delete_avatar
    current_user.avatar=nil
    current_user.save
    redirect_to root_path
  end

  # registro mediante redes sociales
  def social
    provider = params[:provider]
    token = params[:token]

    if provider == "facebook"
      first_name = RestClient.get 'https://graph.facebook.com/me', {:params => {"fields" => "first_name", 'access_token' => token}, :accept => :json}
      first_name = JSON.parse(first_name)["first_name"]
      last_name = RestClient.get 'https://graph.facebook.com/me', {:params => {"fields" => "last_name", 'access_token' => token}, :accept => :json}
      last_name = JSON.parse(last_name)["last_name"]
      email = RestClient.get 'https://graph.facebook.com/me', {:params => {"fields" => "email", 'access_token' => token}, :accept => :json}
      email = JSON.parse(email)["email"]
      picture = RestClient.get 'https://graph.facebook.com/v2.6/me/picture', {:params => {"type" => "large", "redirect" => "false", 'access_token' => token }, :accept => :json}
      picture = JSON.parse(picture)["data"]["url"]
    else
      data = first_name = RestClient.get 'https://www.googleapis.com/oauth2/v2/userinfo', {:params => {'access_token' => token}, :accept => :json}
      data = JSON.parse(data)
      first_name = data["given_name"]
      last_name = data["family_name"]
      # gender = data["gender"]
      email = data["email"]
      picture = data["picture"]
    end

    @user = User.find_by_email(email)
    if @user == nil
      pass = Devise.friendly_token[0,20]
      @user = User.new(username: first_name+" "+last_name, email: email, password: pass, password_confirmation: pass)
      @user.avatar = picture
      @user.admin = false
      @user.save
    else
      @user.avatar = picture
      @user.save
    end

    #logger.debug "Logger: " + LoginSerializer.new(@user).as_json.to_s
    if @user.persisted? then
      @user.reload

      sign_in :user, @user
      @user.avatar_file_name = URI.join(request.url, @user.avatar.url).path if current_user!=nil
      render json: {logged_as: @user}#, serializer: LoginSerializer
    else
      logger.debug "Error durante el login social: #{@user.errors.full_messages.to_sentence}"
      render json: { error: @user.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end  
  protected
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
    def update_resource(resource, params)
      resource.update_without_password(params)
    end
    def account_update_params
      params[:user].delete_if {|k,v| v.blank? }
      params.require(:user).permit(:email, :avatar, :password)
    end
end