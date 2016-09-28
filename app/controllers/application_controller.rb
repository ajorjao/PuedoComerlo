class ApplicationController < ActionController::Base
  before_action :ask_loged

	# rescue_from CanCan::AccessDenied do |exception|
  #    respond_to do |format|
  #      format.json { render json: {error: 'Permisos insuficientes'}, status: :forbidden }
  #      format.html { redirect_to main_app.root_url, :alert => exception.message }
  #    end
  #  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  private
    def ask_loged
      if current_user==nil
        respond_to do |format|
          format.json { render json: {error: 'No estas logeado'}, status: 401 }
          format.html { redirect_to root_path, notice: 'No estas logeado' }
        end
      end
    end
    
    def ask_admin
      if current_user.admin != true
        respond_to do |format|
          format.json { render json: {error: 'Permisos insuficientes'} }
          format.html { redirect_to root_path, notice: 'Permisos insuficientes' }
        end
      end
    end
end
