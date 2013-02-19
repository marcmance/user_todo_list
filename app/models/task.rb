class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :user_id
  belongs_to :user
end
