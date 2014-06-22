FactoryGirl.define do
  factory :ruta_turistica do
  	nom "Ruta testing"
  end

  factory :rt2, :class => "RutaTuristica" do
    nom "Ruta testing 2"
  end
end