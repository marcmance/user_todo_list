class AddDefaultToUserTempPassword < ActiveRecord::Migration
  def change
    change_column :users, :new_password_counter, :integer, :default => 0
  end
end
