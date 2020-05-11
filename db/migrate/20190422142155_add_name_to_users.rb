class AddNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :us_name, :string
    add_column :users, :us_rol, :integer, :limit => 2
    add_column :users, :us_status, :integer, :limit => 2
  end
end
