class AddAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean
    add_column :users, :default, :false
  end
end
