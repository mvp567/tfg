class Pais < ActiveRecord::Base
	has_many :pais_residencias
	has_many :usuaris #nascuts
end
