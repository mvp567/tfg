class DemoController < ApplicationController
	def index
		#render(:template => 'demo/hello')
		#render('hello')
		@arrayInstVar = [1,2,3]
	end
	def hello
		@id = params['id'].to_i
		@page = params[:page].to_i
	end
	def other_hello
		redirect_to(:controller => 'demo' , :action => 'index')
	end
end
