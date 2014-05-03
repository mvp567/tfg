class Favorit < ActiveRecord::Base
	belongs_to :pdi
	belongs_to :usuari
end
