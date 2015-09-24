class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password]) && user.admin
      session[:user_id] = user.id
      redirect_to admin_url
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_admin_session_path, notice: "Adios!"
  end
end
