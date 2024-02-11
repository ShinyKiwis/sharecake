class User < ApplicationRecord
  before_create :generate_friend_code
  has_secure_password

  has_many :friendships, foreign_key: 'user_id', class_name: 'Friendship'
  has_many :friends, through: :friendships
  
  validates :username, :name, presence: true

  def befriend(user)
    self.friends << user
    user.friends << self

    Friendship.find_by(user_id: user.id, friend_id: self.id).update(is_request: true)
  end

  private
  def generate_friend_code
    begin
      random_code_1 = SecureRandom.alphanumeric(4).upcase
      random_code_2 = SecureRandom.alphanumeric(4).upcase
      self.friend_code = "#{random_code_1}-#{random_code_2}"
    end while User.exists?(friend_code: self.friend_code)
  end
end
