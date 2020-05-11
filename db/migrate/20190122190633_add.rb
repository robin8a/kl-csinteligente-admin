class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :ac_predecessor, :integer
    add_column :activities, :ac_days, :integer
  end
end