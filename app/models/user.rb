class User < ActiveRecord::Base
  validates :auth_token, uniqueness: true
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_authentication_token!

  def generate_authentication_token!
    # check the condition after processing the loop.
    loop do
      self.auth_token = Devise.friendly_token
      break if !self.class.exists?(auth_token: auth_token)
    end
  end

end
