class CreateCollaborators < ActiveRecord::Migration[5.2]
  def change
    create_table :collaborators do |t|
      t.string :co_name
      t.string :co_role

      t.timestamps
    end
  end
end
