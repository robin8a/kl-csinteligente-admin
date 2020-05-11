class CreateQaqcs < ActiveRecord::Migration[5.2]
  def change
    create_table :qaqcs do |t|
      t.string :qa_name

      t.timestamps
    end
  end
end
