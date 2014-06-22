FactoryGirl.define do
  factory :pdi do
  	nom "divinus"
    coord_lat "0"
    coord_lng "0"
  end

  factory :pdi2, :class => "Pdi" do
    nom "bacoa"
    coord_lat "0"
    coord_lng "0"
  end
end