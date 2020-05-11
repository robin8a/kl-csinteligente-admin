class CreateObservations < ActiveRecord::Migration[5.2]
  def change
    create_table :observations do |t|
      t.string :ob_name
      t.integer :ob_type
      t.string :ob_desc
      t.text :ob_text

      t.timestamps
    end
  end
end
