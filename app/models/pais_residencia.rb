class PaisResidencia < ActiveRecord::Base
	belongs_to :pais
	belongs_to :usuari
end
