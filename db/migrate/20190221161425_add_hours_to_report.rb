class AddHoursToReport < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :pr_hours, :integer
  end
end
