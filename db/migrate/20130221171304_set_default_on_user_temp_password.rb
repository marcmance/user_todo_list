class SetDefaultOnUserTempPassword < ActiveRecord::Migration
  def up
    change_column :user, :new_password_counter, :default => 0
  end

  def down
  end
end
