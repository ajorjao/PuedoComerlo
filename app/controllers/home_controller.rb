class HomeController < ApplicationController
  def index
  	if !user_signed_in?
  		redirect_to new_user_session_path;
  	end
  end

  def ping
  	render json: { succes: "ok" }
  end
end
