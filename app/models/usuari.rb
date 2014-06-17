class Usuari < ActiveRecord::Base
  has_merit

	validates :nom_usuari, :presence => true, :uniqueness => true, :length => { :in => 3..20}
	validates :email, :presence => true, :uniqueness => true, :format => { :with    => /.+@.+\..+/i }
	validates :password, :presence => true, :length => {:in => 6..20}, :on => :create
	has_secure_password

	has_many :favorits
	#has_many :pdis_favorits, :class_name => "Pdi", through: :favorits
	has_many :favoritas
	has_many :pdis #, :conditions => {:type => ['Restaurant', 'Museu']}
	has_many :valoracios
	has_many :ruta_turisticas
	has_many :usuari_questionaris
	has_many :questionaris, through: :usuari_questionaris

	has_many :pais_residencias
	belongs_to :pais #de naixament

	has_one :authentication


	def crear_amb_omniauth(auth)
		#usu.nom_usuari = auth['user_info']['name']
		#self.create(:nom_usuari => auth['info']['nickname'], :email => "provisional@provisional.com", :password => "provisional")
		
		if auth['provider'] == "twitter"
			self.nom_usuari = auth[:info][:nickname]
			self.email = "provisional@provisional.com"
			self.password = "provisional"
			self.password_confirmation = "provisional"
			#self.save

		elsif auth['provider'] == "facebook"
			nickname = auth[:info][:nickname]
			if nickname.nil?
				self.nom_usuari = (auth[:info][:email].split "@").first
			else
				self.nom_usuari = nickname
			end
			self.email = auth[:info][:email]
			self.password = "provisional"
			self.password_confirmation = "provisional"
			self.nom = auth[:info][:first_name]
			self.cognom = auth[:info][:last_name]

		elsif auth['provider'] == "gplus"
			self.nom_usuari = (auth[:info][:email].split "@").first
			self.email = auth[:info][:email]
			self.password = "provisional"
			self.password_confirmation = "provisional"
			self.nom = auth[:info][:first_name]
			self.cognom = auth[:info][:last_name]
		end


		#a = Authentication.create(:provider => auth['provider'], :uid => auth['uid'])
		a = Authentication.new
		a.provider = auth['provider']
		a.uid = auth['uid']
		a.usuari = self
		a.save

		self.authentication = a
		self.save
		
		
	end
end
