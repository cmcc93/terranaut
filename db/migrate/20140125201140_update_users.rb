class UpdateUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string, :limit => 50
    add_column :users, :first_name, :string, :limit => 25
    add_column :users, :username, :string, :limit => 25
    add_column :users, :email, :string, :default => "", :null => false
    add_column :users, :password_digest, :string
    add_column :users, :remember_token, :string
    add_column :users, :admin, :boolean, :default => false
  end
end
