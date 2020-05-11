class Activity < ApplicationRecord
  belongs_to :activity, optional: true
  has_many :activities, dependent: :destroy
  has_many :baselines, :dependent => :destroy
  has_many :projects, through: :baselines
  has_one :measure, through: :baselines
  has_many :reports

  # Nested CRUD
  accepts_nested_attributes_for :baselines

  def name_with_numbered_list
    "#{ac_numbered_list}  #{ac_name}"
  end
end
