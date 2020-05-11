class CreateMeasures < ActiveRecord::Migration[5.2]
  def change
    create_table :measures do |t|
      t.string :me_name
      t.string :me_unit
      t.boolean :me_is_active

      t.timestamps
    end
  end
end
