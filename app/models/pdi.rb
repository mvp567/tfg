class Pdi < ActiveRecord::Base
  validates :nom, :presence => true, :uniqueness => { :message => "Aquest punt d'interès ja existeix." }
  validates :coord_lat, :presence => { :message => "Aquest punt d'interès no és correcte, torna a buscar siusplau." }
  validates :coord_lng, :presence => true

	belongs_to :usuari
	belongs_to :usuari_modificador, :class_name => "Usuari", :foreign_key => "usuari_modificador_id"

  belongs_to :classe_botiga
  belongs_to :classe_entreteniment
  belongs_to :classe_museu
  belongs_to :classe_restaurant

	has_many :etiquetes_pdis
	has_many :etiqueta, through: :etiquetes_pdis
	has_many :pdis_rutaturisticas
	has_many :favorits
  #has_many :usuaris, through: :favorits
	has_many :valoracios

	def el_meu_save(etiquetes)
		etiquetes_a_enllacar = []

		# Com que no tinc una instància d'Etiqueta, crido la funció estàtica de manera Etiqueta.nom_funció
		self.etiqueta.destroy_all
		Etiqueta.obte_etiquetes(etiquetes).each do |eti|
			#etiquetes_a_enllacar << EtiquetesPdi.new(:etiqueta_id => eti.id)
			self.etiqueta << eti
		end

		#self.etiquetes_pdis = etiquetes_a_enllacar
		
    # millor controlo per validació que no poden ser 0, així no m'asseguro de no tenir pdis inútils
		#if self.coord_lat.blank?
		#	self.coord_lat = 0
		#	self.coord_lng = 0
		#end
    self.punts = 0
		self.save
	end

	def calcula_punts
		valoracions = self.valoracios
		if valoracions.count > 0
			puntsPDI = 0
    		valoracions.each do |v|
      			puntsPDI += (v.punts * Usuari.find_by_id(v.usuari_id).points/1000)
   			end
      		puntsPDI /= valoracions.count
      		self.punts = puntsPDI
      		self.save
      	end
	end


  self.table_name = "pdis"

  scope :close_to, -> (latitude, longitude, distance_in_meters) {
    where(%{
      ST_DWithin(
        ST_GeographyFromText(
          'SRID=4326;POINT(' || pdis.coord_lng || ' ' || pdis.coord_lat || ')'
        ),
        ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
        %d
      )
    } % [longitude, latitude, distance_in_meters])
  }


  scope :distance_to, -> (latitude, longitude) {
    order(%{
      ST_Distance(
        ST_GeographyFromText(
          'SRID=4326;POINT(' || pdis.coord_lng || ' ' || pdis.coord_lat || ')'
        ),
        ST_GeographyFromText('SRID=4326;POINT(%f %f)')
      ) asc
    } % [longitude, latitude])
  }

  scope :tipus_concret, -> (tipus) {
    where("type = '" + tipus + "'")
  }

end
