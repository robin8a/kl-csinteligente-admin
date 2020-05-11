class AddMeasureToBaseline < ActiveRecord::Migration[5.2]
  def change
    add_reference :baselines, :measure, foreign_key: true
  end
end
