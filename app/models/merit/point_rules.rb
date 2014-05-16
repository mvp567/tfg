# Be sure to restart your server when you modify this file.
#
# Points are a simple integer value which are given to "meritable" resources
# according to rules in +app/models/merit/point_rules.rb+. They are given on
# actions-triggered, either to the action user or to the method (or array of
# methods) defined in the +:to+ option.
#
# 'score' method may accept a block which evaluates to boolean
# (recieves the object as parameter)

module Merit
  class PointRules
    include Merit::PointRulesMethods

    def initialize
      # score 10, :on => 'users#update' do
      #   user.name.present?
      # end
      #
      # score 15, :on => 'reviews#create', :to => [:reviewer, :reviewed]
      #
      # score 20, :on => [
      #   'comments#create',
      #   'photos#create'
      # ]

      score 10, :on => 'valoracios#create' do |val|
        #val.pdi.valoracios.count == 3

        #if !val.pdi.nil? && val.pdi.valoracios.count > 0
         # puntsPDI = 0
          #val.pdi.valoracios.each do |v|
           # puntsPDI += (v.punts * Usuari.find_by_id(v.usuari_id).punts/1000)
          #end
          #puntsPDI /= val.pdi.valoracios.count
        #end

        #puntsPDI > 5
      end

    end
  end
end
