require 'pry'
class PagesController < ApplicationController
  before_action :authenticate

  def dashboard
    request_friendship_list = helpers.get_request_friendship_list
    @events = get_bday(params[:start_date])
    @request_friend_list = []
    request_friendship_list.each do |request|
      @request_friend_list << User.find(request.friend_id)
    end
  end

  private
  def authenticate
    redirect_to login_path if not current_user
  end

  def get_bday(request_date)
    bdays = []
    friend_ids = current_user.friends.pluck(:id) << current_user.id
    request_date = request_date.nil? ? Time.now : Date.parse(request_date) 

    bdays_in_requested_month = Event.where("EXTRACT(MONTH from start_time) = ? AND owner IN (?)", request_date.month, friend_ids)
    bdays_in_requested_month.each do |bday|
      if current_user.id != bday.owner && Friendship.find_by(user_id: current_user.id, friend_id: bday.owner).confirmation == false
        next
      end
      bday.name = "🎂 Your Birthday" if bday.owner == current_user.id
      bday.start_time = bday.start_time.change(year: request_date.year)
      bdays << bday
    end
    bdays
  end

  def get_all_bday
  end
end
