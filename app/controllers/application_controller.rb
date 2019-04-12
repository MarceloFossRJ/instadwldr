class ApplicationController < ActionController::Base
  include SessionInfo

  before_action :set_session_id

  # Sets the current user into a named Thread location so that it can be accessed by models and observers
  def set_session_id
    session[:session_id] = request.session_options[:id]
    SessionInfo.session_id = request.session_options[:id]
  end
end
