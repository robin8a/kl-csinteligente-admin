class Baseline < ApplicationRecord
  # Relations
  belongs_to :baseline, optional: true
  has_many :baseline, dependent: :destroy
  belongs_to :project
  belongs_to :activity
  belongs_to :measure, optional: true
  belongs_to :baseline, optional: true

  # Callbacks
  after_save :update_project_dates


  def update_project_dates
    p "# Model Baseline update_project_dates"
    p "# Model Baseline update_project_dates #{self.activity_id} "
    activity_temp = Activity.find(self.activity_id) 
    project_activity = activity_temp.projects[0]
    maximumActDate = project_activity.activities.maximum("ac_end_date")
    p "# Model Baseline update_project_dates maximumActDate: #{maximumActDate} "
    project_activity.update_attributes(pr_end_date: maximumActDate, updated_at: Time.now)    
  end
end
