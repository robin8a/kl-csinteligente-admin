class CreateHelps < ActiveRecord::Migration[5.2]
  def change
    create_table :helps do |t|
      t.references :project, foreign_key: true
      t.references :collaborator, foreign_key: true
      t.references :equipment, foreign_key: true
      t.references :weather, foreign_key: true
      t.references :qaqc, foreign_key: true

      t.timestamps
    end
  end
end
