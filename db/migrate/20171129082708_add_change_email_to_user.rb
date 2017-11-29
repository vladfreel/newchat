class AddChangeEmailToUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :email, :string, :null => true, :unique => false
    add_column :users, :login, :string, :null => true
  end
end
