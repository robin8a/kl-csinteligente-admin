class AddHoursToDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :details, :de_hours, :integer
  end
end
