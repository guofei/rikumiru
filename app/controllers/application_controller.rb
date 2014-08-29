class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin_check
    unless current_user && current_user.role == "admin"
      redirect_to root_path
    end
  end
end
