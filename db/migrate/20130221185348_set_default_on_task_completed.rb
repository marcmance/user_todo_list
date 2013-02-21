class SetDefaultOnTaskCompleted < ActiveRecord::Migration
  def up
    change_column :tasks, :completed, :boolean, :default => false
  end

  def down
  end
end
