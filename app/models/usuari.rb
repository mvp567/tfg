class Usuari < ActiveRecord::Base
  has_merit

	validates :nom_usuari, :presence => true, :uniqueness => true, :length => { :in => 3..20}
	validates :email, :presence => true, :uniqueness => true, :format => { :with    => /.+@.+\..+/i }
	validates :password, :presence => true, :length => {:in => 6..20}, :on => :create
	has_secure_password

	has_many :favorits
	has_many :pdis #, :conditions => {:type => ['Restaurant', 'Museu']}
	has_many :valoracios
	has_many :ruta_turisticas

end
