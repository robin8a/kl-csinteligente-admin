class CreateRealcosts < ActiveRecord::Migration[5.2]
  def change
    create_table :realcosts do |t|
      t.date :re_date
      t.float :re_value
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
