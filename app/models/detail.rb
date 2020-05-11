class Detail < ApplicationRecord
  belongs_to  :report
  belongs_to  :collaborator, optional: true
  belongs_to  :equipment, optional: true
  belongs_to  :weather, optional: true
  belongs_to  :qaqc, optional: true
  has_many    :detobs
  has_many    :observations, through: :detobs

  # Nested CRUD
  accepts_nested_attributes_for :detobs

end
