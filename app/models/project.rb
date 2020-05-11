class Project < ApplicationRecord
    has_many :manages, :dependent => :destroy
    has_many :users, through: :manages
    has_many :baselines, :dependent => :destroy
    has_many :helps, :dependent => :destroy
    has_many :activities, through: :baselines
    has_many :collaborators, through: :helps
    has_many :equipment, through: :helps
    has_many :weathers, through: :helps
    has_many :qaqcs, through: :helps
end
