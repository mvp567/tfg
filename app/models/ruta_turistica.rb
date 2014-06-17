class RutaTuristica < ActiveRecord::Base
	
	
	belongs_to :usuari
	belongs_to :usuari_modificador, :class_name => "Usuari", :foreign_key => "usuari_modificador_id"

	has_many :pdis_rutaturisticas, :dependent => :destroy
	accepts_nested_attributes_for :pdis_rutaturisticas, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

	has_many :valoracios
  has_many :favoritas
  
	has_one :questionari
	
	def el_meu_save(params_pdis)
		ll = []
    	ordreRuta = 1
      params_pdis.sort! { |a,b| a["ordre"].to_i <=> b["ordre"].to_i }
   		params_pdis.each do |a|
   			#byebug
      		pdi_seleccionat = a.values[1]["id"]
      		if !pdi_seleccionat.blank? && a.values[1]["_destroy"] == "false"
      			ll << PdisRutaturistica.new(:pdi_id => pdi_seleccionat, :ordre => ordreRuta)
      			ordreRuta = ordreRuta + 1

      		end
    	end

    	if ll.count > 0
    		self.pdis_rutaturisticas = ll
    	end

      self.punts = 0
      
    	self.save
	end

	def calcula_punts
		valoracions = self.valoracios
		if valoracions.count > 0
			puntsRT = 0
    		valoracions.each do |v|
      			puntsRT += (v.punts * Usuari.find_by_id(v.usuari_id).points/1000)
   			end
      		puntsRT /= valoracions.count
      		self.punts = puntsRT
      		self.save
      	end
	end
end
