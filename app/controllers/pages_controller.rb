require 'pry'
class PagesController < ApplicationController
  before_action :authenticate

  def dashboard
    request_friendship_list = helpers.get_request_friendship_list
    @request_friend_list = []
    request_friendship_list.each do |request|
      @request_friend_list << User.find(request.friend_id)
    end
    @request_friend_list
  end

  private
  def authenticate
    redirect_to login_path if not current_user
  end
end
