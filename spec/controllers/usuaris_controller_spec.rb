# per executar, a la consola fer:
# $ rspec spec/controllers/usuaris_controller_spec.rb

require 'rails_helper'

RSpec.describe UsuarisController, :type => :controller do

	let(:usuari) { FactoryGirl.build :usuari }
  	let(:usuari2) { FactoryGirl.build :usuari2 }
  	let(:usuari_invalid) { FactoryGirl.build :usuari_invalid }

	describe "GET #show" do 
		it "assigna l'usuari demanat a @usuari" do
			usuari.save
			get :show, id: usuari
			expect(assigns(:usuari)).to eq(usuari)
		end
		it "renders la vista de :show" do
			usuari.save
			get :show, id: usuari
			expect(response).to render_template(:show)
		end
	end 

	describe "GET #new" do 
		it "assigna nou Usuari a @usuari" do
			get :new
			expect(assigns(:usuari)).to be_a_new(Usuari)
		end
		it "renders la vista :new" do
			usuari.save
			get :new, id: usuari
			expect(response).to render_template(:new)
		end
	end 

	describe "POST #create" do 
		context "amb attributes valids" do 
			it "guarda nou usuari a la base de dades" do
				expect {
					post :create, usuari: FactoryGirl.attributes_for(:usuari)
				}.to change(Usuari, :count).by(1)
			end
			it "redirecciona a la pàgina d'iniciar sessió" do
				post :create, usuari: FactoryGirl.attributes_for(:usuari)
				expect(response).to redirect_to("/sessions/new")
			end
		end 
		context "amb attributes invalids" do 
			it "no es guarda nou usuari a la base de dades" do
				expect {
					post :create, usuari: FactoryGirl.attributes_for(:usuari_invalid)
				}.to_not change(Usuari, :count)
			end
			it "re-renders la vista :new" do
				post :create, usuari: FactoryGirl.attributes_for(:usuari_invalid)
				expect(response).to render_template(:new)
			end
		end 
	end


	describe "PUT #update" do 
		before :each do 
			usuari.save
			@usuari = usuari	
		end

		context "amb attributes valids" do 
			it "carrega l'usuari demanat" do 
				put :update, id: @usuari, usuari: FactoryGirl.attributes_for(:usuari) 
				expect(assigns(:usuari)).to eq(@usuari)
			end
			it "actualitza usuari a la base de dades" do
				put :update, id: @usuari, usuari: FactoryGirl.attributes_for(:usuari, nom:"Maria")
				@usuari.reload
				expect(@usuari.nom).to eq("Maria")
			end
			it "redirecciona a la pàgina de l'usuari actualitzat" do
				post :update, id: @usuari, usuari: FactoryGirl.attributes_for(:usuari)
				expect(response).to redirect_to(@usuari)
			end
		end 
		context "amb attributes invalids" do 
			it "no actualitza usuari a la base de dades" do
				put :update, id: @usuari, usuari: Factory.attributes_for(:usuari, nom: nil) 
				@usuari.reload 
				expect(@usuari.nom).to eq("Maria")
			end
			it "re-renders la vista :edit" do
				post :update, id: @usuari, usuari: FactoryGirl.attributes_for(:usuari_invalid)
				expect(response).to render_template(:edit)
			end
		end 
	end
end
