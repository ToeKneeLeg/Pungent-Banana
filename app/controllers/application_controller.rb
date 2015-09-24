class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    else
      if current_user.admin != true
        flash[:alert] = "You are not logged in as an admin."
        redirect_to admin_path 
      end
    end
  end

  # def admin_access
  #   # if !admin_user
  #     if admin_user.try(:admin)
  #       flash[:alert] = "You are not logged in as an admin."
  #       redirect_to new_admin_session_path
  #     end
  #   # end
  # end

  # def admin_user
  #   @admin_user ||= User.find(session[:admin_user_id]) if session[:admin_user_id]
  # end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
  # helper_method :admin_user
end
