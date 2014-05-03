class LoginAutenticador
	def initialize(usuari)
		@usuari = usuari
	end

	def authenticate
		byebug
		existeix_usuari = Usuari.where(:nom_usuari => @usuari.nom_usuari).first
		byebug
		if existeix_usuari && existeix_usuari.authenticate(@usuari.password)
			@usuari.attributes = existeix_usuari.attributes
			return true
		else
			@usuari.errors.add(:base, 'Nom d\'usuari invàlid o contrasenya errònea')
		end
		false
	end
end