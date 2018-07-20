class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  
  validates_uniqueness_of :email
  validates :first_name, presence: true
  validates :last_name, presence: true

end
