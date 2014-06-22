# per executar, a la consola fer:
# $ rspec spec/models/ruta_turistica_spec.rb

require 'rails_helper'
require 'factory_girl_rails'

RSpec.describe RutaTuristica, :type => :model do
  
  let(:rt) { FactoryGirl.build :ruta_turistica }
  let(:rt2) { FactoryGirl.build :ruta_turistica }

  it "es pot crear" do
  	expect(rt).to be_valid
  end

  it "es invalida sense nom" do
  	rt.nom = nil
  	expect(rt).to_not be_valid
  end

end
