class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :null_session
  def default_url_options
    { host: request.host_with_port }
  end
  # Use callbacks to share common setup or constraints between actions.
  
end
