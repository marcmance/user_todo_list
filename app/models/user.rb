class User < ActiveRecord::Base
  extend ActiveSupport::Memoizable
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :user_type
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence   => true,
            :format     => { :with => email_regex },
            :uniqueness => true

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_many :tasks

  def admin?
    self.user_type == "admin" ? true : false
  end

  def completed_tasks
    tasks.completed
  end
  memoize :completed_tasks

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


end
