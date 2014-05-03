class Usuari < ActiveRecord::Base
	validates :nom_usuari, :presence => true, :uniqueness => true, :length => { :in => 3..20}
	validates :email, :presence => true, :uniqueness => true, :format => { :with    => /.+@.+\..+/i }
	validates :password, :presence => true, :length => {:in => 6..20}, :on => :create
	has_secure_password

	has_many :favorits
	has_many :pdis
	#def self.authenticate(usuari)
	#	LoginAutenticador.new(usuari).authenticate
	#end
end
