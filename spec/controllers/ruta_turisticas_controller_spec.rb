# per executar, a la consola fer:
# $ rspec spec/controllers/ruta_turisticas_controller_spec.rb

require 'rails_helper'

RSpec.describe RutaTuristicasController, :type => :controller do

	let(:rt) { FactoryGirl.build :ruta_turistica }
  	let(:rt2) { FactoryGirl.build :ruta_turistica }


	describe "GET #index" do 
		it "omple array de rutes turístiques" do
			get :index 
			expect(assigns(:ruta_turisticas)).to eq([rt])
		end 

		it "renders la vista :index" do 
			get :index 
			expect(response).to render_template(:index)
		end 
	end

	describe "GET #show" do 
		it "assigna la ruta demanada a @rt" do
			rt.save
			get :show, id: rt
			expect(assigns(:ruta_turistica)).to eq(rt)
		end
		it "renders la vista de :show" do
			rt.save
			get :show, id: rt
			expect(response).to render_template(:show)
		end
	end 

	describe "GET #new" do 
		it "assigna nova ruta turística a @rt" do
			get :new
			expect(assigns(:ruta_turistica)).to be_a_new(rt)
		end
		it "renders la vista :new" do
			rt.save
			get :new, id: rt
			expect(response).to render_template(:new)
		end
	end 

	describe "POST #create" do 
		context "amb attributes valids" do 
			it "guarda nova ruta a la base de dades" do
				expect {
					post :create, ruta_turistica: FactoryGirl.attributes_for(:rt)
				}.to change(rt, :count).by(1)
			end
			it "redirecciona a la pàgina de la ruta acabada de crear" do
				post :create, ruta_turistica: FactoryGirl.attributes_for(:rt)
				expect(response).to redirect_to("/sessions/new")
			end
		end 
		context "amb attributes invalids" do 
			it "no es guarda nova ruta a la base de dades" do
				expect {
					post :create, ruta_turistica: FactoryGirl.attributes_for(:rt2)
				}.to_not change(rt, :count)
			end
			it "re-renders la vista :new" do
				post :create, ruta_turistica: FactoryGirl.attributes_for(:rt2)
				expect(response).to render_template(:new)
			end
		end 
	end

	describe "PUT #update" do 
		before :each do 
			rt.save
			@rt = rt	
		end

		context "amb attributes valids" do 
			it "carrega ruta demanada" do 
				put :update, id: @rt, ruta_turistica: FactoryGirl.attributes_for(:rt) 
				expect(assigns(:ruta_turistica)).to eq(@rt)
			end
			it "actualitza ruta a la base de dades" do
				put :update, id: @rt, ruta_turistica: FactoryGirl.attributes_for(:rt, nom:"rutaa")
				@rt.reload
				expect(@rt.nom).to eq("rutaa")
			end
			it "redirecciona a la pàgina de la ruta actualitzada" do
				post :update, id: @rt, ruta_turistica: FactoryGirl.attributes_for(:rt)
				expect(response).to redirect_to(@rt)
			end
		end 
		context "amb attributes invalids" do 
			it "no actualitza ruta a la base de dades" do
				put :update, id: @rt, ruta_turistica: Factory.attributes_for(:rt, nom: nil) 
				@rt.reload 
				expect(@rt.nom).to eq("rutaa")
			end
			it "re-renders la vista :edit" do
				post :update, id: @rt, ruta_turistica: FactoryGirl.attributes_for(:rt2)
				expect(response).to render_template(:edit)
			end
		end 
	end

end
