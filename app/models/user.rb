class User < ApplicationRecord
  before_create :generate_friend_code
  has_secure_password

  validates :username, :name, presence: true

  private
  def generate_friend_code
    begin
      random_code_1 = SecureRandom.alphanumeric(4).upcase
      random_code_2 = SecureRandom.alphanumeric(4).upcase
      self.friend_code = "#{random_code_1}-#{random_code_2}"
    end while User.exists?(friend_code: self.friend_code)
  end
end
