class RutaTuristica < ActiveRecord::Base
	
	
	belongs_to :usuari
	belongs_to :usuari_modificador, :class_name => "Usuari", :foreign_key => "usuari_modificador_id"

	has_many :pdis_rutaturisticas, :dependent => :destroy
	accepts_nested_attributes_for :pdis_rutaturisticas, :allow_destroy => true

	has_many :valoracios
	
	def el_meu_save(params_pdis)
		ll = []
    	ordreRuta = 1
   		params_pdis.each do |a|
      		pdi_seleccionat = a.values[1]["id"]
      		ll << PdisRutaturistica.new(:pdi_id => pdi_seleccionat, :ordre => ordreRuta)
      		ordreRuta = ordreRuta + 1
    	end

    	self.pdis_rutaturisticas = ll

    	self.save
	end

	def calcula_punts
		valoracions = self.valoracios
		if valoracions.count > 0
			puntsRT = 0
    		valoracions.each do |v|
      			puntsRT += (v.punts * Usuari.find_by_id(v.usuari_id).punts/1000)
   			end
      		puntsRT /= valoracions.count
      		self.punts = puntsRT
      		self.save
      	end
	end
end
