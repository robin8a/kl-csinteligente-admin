class AddRolToCsUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :cs_users, :rol, :string
  end
end
