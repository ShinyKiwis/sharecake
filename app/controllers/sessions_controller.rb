class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid username or password!"
      render :new, status: :unauthorized
    end
  end

  def destroy
    session.delete(:current_user_id)
    redirect_to login_path, status: :see_other
  end
end
