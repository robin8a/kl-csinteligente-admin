class CreateDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :details do |t|
      t.float :de_amount
      t.integer :de_hour
      t.references :collaborator, foreign_key: true
      t.references :equipment, foreign_key: true
      t.references :weather, foreign_key: true
      t.references :qaqc, foreign_key: true

      t.timestamps
    end
  end
end
