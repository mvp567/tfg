class EtiquetesPdi < ActiveRecord::Base
	belongs_to :etiqueta
	belongs_to :pdi
end
