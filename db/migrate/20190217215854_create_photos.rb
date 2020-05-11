class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :ph_name
      t.string :ph_src
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
