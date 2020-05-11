class Help < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :collaborator, optional: true
  belongs_to :equipment, optional: true
  belongs_to :weather, optional: true
  belongs_to :qaqc, optional: true
end
