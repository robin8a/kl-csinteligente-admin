class Report < ApplicationRecord
  belongs_to :activity
  belongs_to :contractor, :class_name => 'CsUser', optional: true
  belongs_to :controller, :class_name => 'CsUser', optional: true
  has_many :details, dependent: :destroy

  def re_status_text
    @status_text
    if re_status == "1"
        @status_text = "Guardado"
    elsif re_status == "2"
        @status_text = "Por aprobar"
    else
        @status_text = "Aprobado"
    end
    "#{@status_text}"
end
end
