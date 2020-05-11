class CreateBaselines < ActiveRecord::Migration[5.2]
  def change
    create_table :baselines do |t|
      t.references :project, foreign_key: true
      t.references :activity, foreign_key: true
      t.string :ba_status
      t.string :ba_type
      t.integer :ba_amount
      t.integer :ba_price
      t.references :baseline, foreign_key: true

      t.timestamps
    end
  end
end
