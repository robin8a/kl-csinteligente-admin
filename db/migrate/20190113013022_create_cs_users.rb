class CreateCsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :cs_users do |t|
      t.string :nickname

      t.timestamps
    end
  end
end
