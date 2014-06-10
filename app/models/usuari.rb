class Usuari < ActiveRecord::Base
  has_merit

	validates :nom_usuari, :presence => true, :uniqueness => true, :length => { :in => 3..20}
	validates :email, :presence => true, :uniqueness => true, :format => { :with    => /.+@.+\..+/i }
	validates :password, :presence => true, :length => {:in => 6..20}, :on => :create
	has_secure_password

	has_many :favorits
	#has_many :pdis_favorits, :class_name => "Pdi", through: :favorits
	has_many :pdis #, :conditions => {:type => ['Restaurant', 'Museu']}
	has_many :valoracios
	has_many :ruta_turisticas
	has_many :usuari_questionaris
	has_many :questionaris, through: :usuari_questionaris

	has_many :pais_residencias
	belongs_to :pais #de naixament

	has_one :authentication


	def self.crear_amb_omniauth(auth)
		#usu.nom_usuari = auth['user_info']['name']
		usu = Usuari.create(:nom_usuari => "mariaaa")
		usu.authentication = Authentication.create(:provider => auth['provider'], :uid => auth['uid'])
			
		
		
	end
end
