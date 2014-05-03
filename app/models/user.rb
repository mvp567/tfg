class User < ActiveRecord::Base
	
	# accessors example (no calen pq ActiveRecord ho porta implícit)
	# short way
	attr_accessor :first_name
	# long way
	# getter
	def last_name
		@last_name
	end
	#setter
	def last_name=(value)
		@last_name = value
	end
	# accessors example end
end
