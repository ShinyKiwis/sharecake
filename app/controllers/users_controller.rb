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
        flash.now[:alert] = "Old password is wrong. Please try again."
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

  def add_friend
    if User.exists?(friend_code: friend_params[:new_friend_code])
      friend = User.find_by_friend_code(friend_params[:new_friend_code])
      current_user.befriend(friend)
      flash[:notice] = "Waiting for your friend's approval."
      redirect_to root_path
    else
      flash[:alert] = "Friend code is invalid."
      redirect_to root_path
    end
  end

  def accept_friend
    Friendship.find_by(user_id: current_user.id, friend_id: params[:id]).update(confirmation: true)
    Friendship.find_by(user_id: params[:id], friend_id: current_user.id).update(confirmation: true)
    redirect_to root_path
  end

  def reject_friend
    Friendship.find_by(user_id: current_user.id, friend_id: params[:id]).destroy
    Friendship.find_by(user_id: params[:id], friend_id: current_user.id).destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :name, :bday, :password, :new_password)
  end

  def friend_params
    params.require(:user).permit(:new_friend_code)
  end
end
