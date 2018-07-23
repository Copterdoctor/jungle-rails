class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 8 }

  def self.authenticate_with_credentials(user, email, password)
    if (!!(email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)) && user.authenticate(password)
      true
    else
      false
    end
  end
end
