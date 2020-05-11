class CreateDetobs < ActiveRecord::Migration[5.2]
  def change
    create_table :detobs do |t|
      t.references :detail, foreign_key: true
      t.references :observation, foreign_key: true

      t.timestamps
    end
  end
end
