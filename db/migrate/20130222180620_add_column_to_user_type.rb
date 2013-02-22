class AddColumnToUserType < ActiveRecord::Migration
  def change
    add_column :users, :user_type, :string, :default => "standard"
  end
end
