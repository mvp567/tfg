class PdisRutaturistica < ActiveRecord::Base
	belongs_to :pdi
	belongs_to :ruta_turistica

	accepts_nested_attributes_for :pdi, :allow_destroy => true
end
