module PagesHelper
  def get_profile_letters(name)
    name.split[-2..-1].map {|word| word[0].upcase}.join
  end

  def is_waiting_for_accepted_friend?(friend_id)
    Friendship.find_by(user_id: current_user.id, friend_id: friend_id).confirmation == false
  end

  def get_request_friendship_list
    Friendship.where(user_id: current_user.id, is_request: true)
  end
end
