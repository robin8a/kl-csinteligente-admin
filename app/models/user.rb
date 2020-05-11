class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # relations
  has_many :manages
  has_many :projects, through: :manages
  has_many :works
  has_many :enterprises, through: :works
  has_many :contractor_reports, :class_name => 'Report', :foreign_key => 'contractor_id'
  has_many :controller_reports, :class_name => 'Report', :foreign_key => 'controller_id'
  
  # enums 
  enum us_rol: [:admin, :client, :contractor, :controller]

  def name_and_rol
    @rol_text
    if admin?
        @rol_text = "Administrador"
    elsif client?
        @rol_text = "Cliente"
    elsif contractor?
        @rol_text = "Contratista"
    else
        @rol_text = "Interventor"
    end

    "#{us_name}/#{@rol_text}"
  end

end
