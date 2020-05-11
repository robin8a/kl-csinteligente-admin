class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.text :ac_numbered_list
      t.text :ac_name
      t.date :ac_start_date
      t.date :ac_end_date
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
