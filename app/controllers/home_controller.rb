class HomeController < ApplicationController
	skip_before_action :ask_loged, only: [:index, :ping ]

  def index
  	if !user_signed_in?
  		redirect_to new_user_session_path;
  	end
    @notifications = Notification.order(created_at: :desc).paginate(page: 1, per_page: 5)
  end

  def ping
  	render json: { succes: "ok" }
  end
end
