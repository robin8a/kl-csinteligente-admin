class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.text :pr_name
      t.text :pr_description
      t.date :pr_start_date
      t.date :pr_end_date
      t.float :pr_admon
      t.float :pr_incidental
      t.float :pr_indirect_cost
      t.float :pr_profit
      t.float :pr_tax_iva

      t.timestamps
    end
  end
end
