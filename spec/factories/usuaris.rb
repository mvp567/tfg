# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :usuari do
  	nom_usuari "john_doe" 
  	email "john_doe@email.com"
  	password "123456"
  	password_confirmation "123456"
  end

  factory :usuari2, :class => "Usuari" do
  	nom_usuari "jane_doe" 
  	email "jane_doe@email.com"
  	password "123456"
  	password_confirmation "123456"
  end

  factory :usuari_invalid, :parent => :usuari do
  	email nil
  end
end
