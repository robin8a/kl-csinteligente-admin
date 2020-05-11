class AddReportToDetail < ActiveRecord::Migration[5.2]
  def change
    add_reference :details, :report, foreign_key: true
  end
end
