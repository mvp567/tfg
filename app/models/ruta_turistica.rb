class RutaTuristica < ActiveRecord::Base
	has_many :pdis_rutaturisticas, :dependent => :destroy
	belongs_to :usuari
	belongs_to :usuari_modificador, :class_name => "Usuari", :foreign_key => "usuari_modificador_id"

	accepts_nested_attributes_for :pdis_rutaturisticas, :allow_destroy => true

	

end
