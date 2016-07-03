class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  prepend_before_filter :require_no_authentication, :only => [ :get ]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    if current_user == nil
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
            format.json { render json: {error: 'tiempo de registro expirado'}, status: 408 }
            format.html { respond_with resource, location: after_inactive_sign_up_path_for(resource) }
          end
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        #respond_with resource
        @error = ''
        if /.+@.+\..+/.match(params['user']['email']) == nil
          @error = 'email incorrecto'
        else
          if User.find_by_email(params['user']['email']) != nil
            @error = 'email existente'
          else
            @error = 'passwords incorrectos'
          end
        end
        respond_to do |format|
          format.json { render json: { error: @error}, status: 400 }
          format.html { respond_with resource }
        end
      end
    else
      render json: {error: "Ya estas logeado como '#{current_user.email}'"}
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
      render json: {error: 'No estas logeado'}, status: 401
    else
      if current_user.update(account_update_params)
        current_user.avatar_file_name = URI.join(request.url, current_user.avatar.url).path
        render json: {edited: current_user}
      else
        render json: {error: 'Permisos insuficientes'}, status: 403
      end
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  def users
    if current_user == nil
      render json: {error: 'No estas logeado'}, status: 401
    elsif current_user.admin == true
      @users = User.order("email ASC").paginate(page: params[:page])
      @users.each do |user|
        user.avatar_file_name = URI.join(request.url, user.avatar.url).path
      end
      render json: @users
      #will_paginate @users        #en las vistas se usa para tener una barra con las paginas disponibles
    else
      render json: {error: 'Permisos insuficientes'}
    end
  end

  def user_delete
    if current_user == nil
      render json: {error: 'No estas logeado'}, status: 401
    elsif current_user.id == params[:id].to_i or current_user.admin == true
      @user = User.where(id: params[:id])
      if @user == []
        render json: {error: 'Usuario inexistente'}, status: 404
      elsif User.delete(params[:id])
        render json: {success: 'Eliminacion exitosa'}
      else
        render json: {error: 'Problema de eliminacion'}, status: 401
      end
    else
      render json: {error: 'No posees los permisos para eliminar este usuario'}, status: 403
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