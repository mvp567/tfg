class Pdi < ActiveRecord::Base
	belongs_to :usuari
	belongs_to :usuari_modificador, :class_name => "Usuari", :foreign_key => "usuari_modificador_id"

	has_many :etiquetes_pdis
	has_many :pdis_rutaturisticas
	has_many :favorits

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
