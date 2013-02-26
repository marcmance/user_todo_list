class Task < ActiveRecord::Base
  extend ActiveSupport::Memoizable
  attr_accessible :completed, :description, :user_id
  belongs_to :user

  scope :completed, -> { where("completed IS true") }
  scope :not_completed, -> { where("completed IS NOT true") }

  def test_mem
    "#{user_id} #{description}"
  end
  memoize :test_mem
end
