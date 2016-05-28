class ApplicationController < ActionController::Base
	rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render json: {error: 'Permisos insuficientes'}, status: :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
end
