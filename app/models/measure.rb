class Measure < ApplicationRecord
    has_many :baselines

    def name_with_unit
        "#{me_name}/ #{me_unit}"
    end
end
