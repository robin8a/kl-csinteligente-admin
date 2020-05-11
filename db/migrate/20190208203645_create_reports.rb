class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.date :re_date
      t.float :re_amount
      t.references :activity, foreign_key: true
      t.references :contractor
      t.references :controller
      t.timestamps
    end
  end
end
