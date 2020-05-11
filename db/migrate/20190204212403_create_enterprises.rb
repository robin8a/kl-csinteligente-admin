class CreateEnterprises < ActiveRecord::Migration[5.2]
  def change
    create_table :enterprises do |t|
      t.string :en_name

      t.timestamps
    end
  end
end
