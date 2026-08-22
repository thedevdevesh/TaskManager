class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :require_login

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def require_login
    redirect_to login_path, alert: "Please log in to continue." unless current_user
  end
end
