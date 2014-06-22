# per executar, a la consola fer:
# $ rspec spec/models/pdi_spec.rb

require 'rails_helper'
require 'factory_girl_rails'

RSpec.describe Pdi, :type => :model do
  
  let(:pdi) { FactoryGirl.build :pdi }
  let(:pdi2) { FactoryGirl.build :pdi2 }

  it "es pot crear" do
  	expect(pdi).to be_valid
  end

  it "es invalid sense nom" do
  	pdi.nom = nil
  	expect(pdi).to_not be_valid
  end

  it "es invalid sense coord_lat" do
  	pdi.coord_lat = nil
  	expect(pdi).to_not be_valid
  end

  it "es invalid sense coord_lng" do
  	pdi.coord_lng = nil
    expect(pdi).to_not be_valid
  end

  it "es unic" do
  	pdi.save
  	pdi2.nom = pdi.nom
  	expect(pdi2).to_not be_valid
  end

end
