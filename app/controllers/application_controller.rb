class ApplicationController < ActionController::Base
  before_action :update_session
  helper_method :current_user

  def current_user
    @current_user ||= User.find_or_create_by(session_id: session[:session_id])
  end

  private

  def update_session
    session[:session_id] ||= SecureRandom.uuid
  end
end
