class Observation < ApplicationRecord
    has_many    :detobs
    has_many    :details, through: :detobs
end
