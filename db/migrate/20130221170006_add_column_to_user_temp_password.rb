class AddColumnToUserTempPassword < ActiveRecord::Migration
  def change
    add_column :users, :new_password_counter, :integer
  end
end
