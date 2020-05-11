class AddIsCostToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :ac_is_cost, :boolean
  end
end
