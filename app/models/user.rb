class User < ApplicationRecord
  before_create :generate_friend_code
  after_create :generate_bday_event
  after_save :generate_bday_event
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

  def generate_bday_event
    if not self.bday.nil? || attribute_changed?(:bday)
      if Event.exists?(owner: self.id)
        Event.update(start_time: self.bday, owner: self.id)
      else
        Event.create(name: "🎂 #{self.name}'s Birthday", start_time: self.bday, owner: self.id)
      end
    end
  end
end
