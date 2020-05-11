class Enterprise < ApplicationRecord
    has_many :works
    has_many :cs_users, through: :works
end
