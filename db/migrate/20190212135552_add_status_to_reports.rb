class AddStatusToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :re_status, :string
  end
end
