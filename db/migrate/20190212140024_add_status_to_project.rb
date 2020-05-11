class AddStatusToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :pr_status, :string
  end
end
