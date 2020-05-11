class AddIsCostToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :is_cost, :boolean
  end
end
