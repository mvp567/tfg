class Etiqueta < ActiveRecord::Base
	has_many :etiquetes_pdis

	# Funció estàtica, va amb el self davant
	def self.obte_etiquetes(etiquetes)
		etiquetes_array = etiquetes.split ","
		etiquetes_a_retornar = []

		etiquetes_array.each do |eti|
			etiqueta_db = Etiqueta.where(:nom => eti).first
			
			# Manera 1 de fer-ho:
			if etiqueta_db.nil?
				etiqueta_db = Etiqueta.new(:nom => eti)
				etiqueta_db.save
			end

			# Manera 2 de fer-ho:
			# etiqueta_db ||= Etiqueta.new(:nom => eti)
			# etiqueta_db.save if etiqueta_db.new_record?

			etiquetes_a_retornar << etiqueta_db
		end

		return etiquetes_a_retornar
	end

end
