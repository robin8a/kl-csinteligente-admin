class AddHoursToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :pr_hours, :integer
  end
end
