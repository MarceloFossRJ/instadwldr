class ApplicationController < ActionController::Base
  include SessionInfo

  before_action :set_session_id
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
  end
    # Sets the current user into a named Thread location so that it can be accessed by models and observers
  def set_session_id
    session[:session_id] = request.session_options[:id]
    SessionInfo.session_id = request.session_options[:id]
  end
end
