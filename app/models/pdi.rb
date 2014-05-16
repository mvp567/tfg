class Pdi < ActiveRecord::Base
	belongs_to :usuari
	belongs_to :usuari_modificador, :class_name => "Usuari", :foreign_key => "usuari_modificador_id"

	has_many :etiquetes_pdis
	has_many :pdis_rutaturisticas
	has_many :favorits
	has_many :valoracios

	

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

	def calcula_punts
		valoracions = self.valoracios
		if valoracions.count > 0
			puntsPDI = 0
    		valoracions.each do |v|
      			puntsPDI += (v.punts * Usuari.find_by_id(v.usuari_id).punts/1000)
   			end
      		puntsPDI /= valoracions.count
      		self.punts = puntsPDI
      		self.save
      	end
	end

end
