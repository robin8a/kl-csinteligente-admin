class CsUser < ApplicationRecord
    has_many :manages
    has_many :projects, through: :manages
    has_many :works
    has_many :enterprises, through: :works
    has_many :contractor_reports, :class_name => 'Report', :foreign_key => 'contractor_id'
    has_many :controller_reports, :class_name => 'Report', :foreign_key => 'controller_id'

    def name_and_rol
        @rol_text
        if rol == "1"
            @rol_text = "Administrador"
         elsif rol == "2"
            @rol_text = "Cliente"
        elsif rol == "3"
            @rol_text = "Contratista"
        else
            @rol_text = "Interventor"
        end

        "#{nickname}/#{@rol_text}"
    end
end
