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

      score 50, :on => ['usuaris#create']
      
      score 10, :on => ['sessions#create']

      score 10, :on => 'valoracios#create', :to => :pointer do |val|
        spm = false
        if !val.pdi.nil?
          if val.pdi.valoracios.count.modulo(5).zero?
              ultimes_vals = val.pdi.valoracios.order('created_at DESC').limit(5) #.each_with_index do |s, i|
              puntsPDI = 0

              ultimes_vals.each do |v|
                puntsPDI += (v.punts * Usuari.find_by_id(v.usuari_id).points/1000)
              end

              puntsPDI /= 5

              if puntsPDI >= 5
                spm = true
              end
          end

          spm == true

        end
      end #score


      score 50, :on => 'valoracios#create', :to => :pointerrt do |val|
        spm = false
        if !val.ruta_turistica.nil?
          if val.ruta_turistica.punts >= 5
            spm = true
          end

          spm == true

        end
      end #score

    end #def initialize
  end #class
end #Module
