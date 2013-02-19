class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence   => true,
            :format     => { :with => email_regex },
            :uniqueness => true

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

end
