# per executar, a la consola fer:
# $ rspec spec/models/usuari_spec.rb

require 'rails_helper'
require 'factory_girl_rails'

RSpec.describe Usuari, :type => :model do
  
  let(:usuari) { FactoryGirl.build :usuari }
  let(:usuari2) { FactoryGirl.build :usuari2 }

  it "es pot crear" do
  	expect(usuari).to be_valid
  end

  it "es invalid sense nom d'usuari" do
  	usuari.nom_usuari = nil
  	expect(usuari).to_not be_valid
  end

  it "es invalid sense email" do
  	usuari.email = nil
  	expect(usuari).to_not be_valid
  end

  it "te contrasenya invalida" do
  	usuari.password = "123"
  	expect(usuari).to_not be_valid
  end

  it "te nom_usuari unic" do
  	usuari.save
  	usuari2.nom_usuari = usuari.nom_usuari
  	expect(usuari2).to be_valid
  end

  it "te format email valid" 
end
