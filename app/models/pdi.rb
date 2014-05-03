class Pdi < ActiveRecord::Base
	belongs_to :localitzacio
	belongs_to :usuari

	has_many :etiquetes_pdis
	has_many :favorits

	accepts_nested_attributes_for :localitzacio

	def el_meu_save(etiquetes)
		etiquetes_a_enllacar = []

		# Com que no tinc una instància d'Etiqueta, crido la funció estàtica de manera Etiqueta.nom_funció
		Etiqueta.obte_etiquetes(etiquetes).each do |eti|
			etiquetes_a_enllacar << EtiquetesPdi.new(:etiqueta_id => eti.id)
		end

		# self és el meu pdi
		self.etiquetes_pdis = etiquetes_a_enllacar
		
		self.save
	end
end
