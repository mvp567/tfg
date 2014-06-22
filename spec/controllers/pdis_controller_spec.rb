# per executar, a la consola fer:
# $ rspec spec/controllers/pdis_controller_spec.rb

require 'rails_helper'

RSpec.describe PdisController, :type => :controller do

	let(:pdi) { FactoryGirl.build :pdi }
  	let(:pdi2) { FactoryGirl.build :pdi2 }


	describe "GET #index" do 
		it "omple array de pdis" do
			get :index 
			expect(assigns(:pdis)).to eq([pdi])
		end 

		it "renders la vista :index" do 
			get :index 
			expect(response).to render_template(:index)
		end 
	end

	describe "GET #show" do 
		it "assigna el pdi demanat a @pdi" do
			pdi.save
			get :show, id: pdi
			expect(assigns(:pdi)).to eq(pdi)
		end
		it "renders la vista de :show" do
			pdi.save
			get :show, id: pdi
			expect(response).to render_template(:show)
		end
	end 

	describe "GET #new" do 
		it "assigna nou pdi a @pdi" do
			get :new
			expect(assigns(:pdi)).to be_a_new(pdi)
		end
		it "renders la vista :new" do
			pdi.save
			get :new, id: pdi
			expect(response).to render_template(:new)
		end
	end 

	describe "POST #create" do 
		context "amb attributes valids" do 
			it "guarda nou pdi a la base de dades" do
				expect {
					post :create, pdi: FactoryGirl.attributes_for(:pdi)
				}.to change(pdi, :count).by(1)
			end
			it "redirecciona a la pàgina del pdi acabat de crear" do
				post :create, pdi: FactoryGirl.attributes_for(:pdi)
				expect(response).to redirect_to("/sessions/new")
			end
		end 
		context "amb attributes invalids" do 
			it "no es guarda nou pdi a la base de dades" do
				expect {
					post :create, pdi: FactoryGirl.attributes_for(:pdi2)
				}.to_not change(pdi, :count)
			end
			it "re-renders la vista :new" do
				post :create, pdi: FactoryGirl.attributes_for(:pdi2)
				expect(response).to render_template(:new)
			end
		end 
	end

	describe "PUT #update" do 
		before :each do 
			pdi.save
			@pdi = pdi	
		end

		context "amb attributes valids" do 
			it "carrega pdi demanat" do 
				put :update, id: @pdi, pdi: FactoryGirl.attributes_for(:pdi) 
				expect(assigns(:pdi)).to eq(@pdi)
			end
			it "actualitza pdi a la base de dades" do
				put :update, id: @pdi, pdi: FactoryGirl.attributes_for(:pdi, nom:"pdinom")
				@pdi.reload
				expect(@pdi.nom).to eq("pdinom")
			end
			it "redirecciona a la pàgina del pdi actualitzat" do
				post :update, id: @pdi, pdi: FactoryGirl.attributes_for(:pdi)
				expect(response).to redirect_to(@pdi)
			end
		end 
		context "amb attributes invalids" do 
			it "no actualitza pdi a la base de dades" do
				put :update, id: @pdi, pdi: Factory.attributes_for(:pdi, nom: nil) 
				@pdi.reload
				expect(@pdi.nom).to eq("pdinom")
			end
			it "re-renders la vista :edit" do
				post :update, id: @pdi, pdi: FactoryGirl.attributes_for(:pdi2)
				expect(response).to render_template(:edit)
			end
		end 
	end

end
