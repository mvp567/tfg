class Localitzacio < ActiveRecord::Base
	#belongs_to :ciutat	
	has_one :pdi

end
