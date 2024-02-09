require 'pry'
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.username = user_params[:username]
    @user.name = user_params[:name]
    @user.bday = user_params[:bday]
    if not user_params[:password].blank?
      if @user.authenticate(user_params[:password])
        @user.password = user_params[:new_password]
      else
        flash.now[:alert] = "Old password is wrong. Please try again"
        render :show, locals: {user: @user}, status: :unprocessable_entity
        return
      end
    end
    if @user.save
      flash[:notice] = "Account update successfully!"
    else
      flash[:alert] = "All required field must be filled!"
    end
    redirect_to fallback_location: user_path(@user)
  end

  private
  def user_params
    params.require(:user).permit(:username, :name, :bday, :password, :new_password)
  end
end
