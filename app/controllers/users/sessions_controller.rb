class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
#    super
    if params[:user]!=nil
      if User.find_by_email(params[:user][:email])!=nil
        self.resource = resource_class.new(sign_in_params)
        clean_up_passwords(resource)
        yield resource if block_given?
        respond_to do |format|
          format.json { render json: { error: "Combinacion de usuario y password incorrectos" }, status: 400 }
          format.html { respond_with(resource, serialize_options(resource)) }
        end
      else
        render json: { error: "Email inexistente" }, status: 400
      end
    else #borrar el if completo cuando eliminemos la vercion web q da rails
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      yield resource if block_given?
      respond_to do |format|
        format.json { render json: { error: "Combinacion de usuario y password incorrectos" }, status: 400 }
        format.html { respond_with(resource, serialize_options(resource)) }
      end
    end
  end

  # POST /resource/sign_in
  def create
    if current_user==nil or current_user.email==params[:user][:email]
      self.resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      @user = User.find_by_email(params[:user][:email])
      @user.avatar_file_name = URI.join(request.url, @user.avatar.url).path
      respond_to do |format|
        format.json { render json: {logged_in: @user} }
        format.html { respond_with resource, location: after_sign_in_path_for(resource) }
      end
    else
      render json: {error: "Ya estas logeado como '#{current_user.email}'"}
    end
  end

  # DELETE /resource/sign_out
  def destroy
    @user = current_user
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    respond_to do |format|
      #format.json { render json: {logged_out: @user.email}, status: 204 }
      format.json { render json: {logged_out: @user.email}}
      format.html { respond_to_on_destroy }
    end
  end

  def user_actual
    @user = current_user
    @user.avatar_file_name = URI.join(request.url, @user.avatar.url).path if current_user!=nil
    families = @user.families if @user!=nil

    render json: { user: @user, family: families }
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
