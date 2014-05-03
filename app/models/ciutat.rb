class Ciutat < ActiveRecord::Base
	belongs_to :pais
	#has_many :localitzacios
end
