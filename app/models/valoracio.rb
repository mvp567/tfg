class Valoracio < ActiveRecord::Base
	belongs_to :ruta_turistica
	belongs_to :pdi
	belongs_to :usuari

	after_create :calcula_punts

	def calcula_punts
		if !self.pdi_id.nil?
			@pdii = Pdi.find_by_id(self.pdi_id)
			@pdii.calcula_punts
		else
			@rtt = RutaTuristica.find_by_id(self.ruta_turistica_id)
			@rtt.calcula_punts
		end
	end

	def pointer
		self.pdi.usuari
	end

	def pointerrt
		self.ruta_turistica.usuari
	end
end
