class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :user_id
  belongs_to :user

  scope :completed, -> { where("completed IS true") }
  scope :not_completed, -> { where("completed IS NOT true") }
end
