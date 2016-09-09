class HomeController < ApplicationController
  def index
  	if !user_signed_in?
  		redirect_to new_user_session_path;
  	end
  end

  def ping
  	render json: { succes: "ok" }
  end

  def sendemail
  	recived = {nombre: params[:nombre], email: params[:mail], mensaje: params[:mensaje] }
  	render json: { recived: recived}
  end
end
