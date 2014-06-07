# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ nom: 'Chicago' }, { nom: 'Copenhagen' }])
#   Mayor.create(nom: 'Emanuel', city: cities.first)

classes_botigues = ClasseBotiga.create([{ nom: 'Roba' }, { nom: 'Sabates' }, { nom: 'Menjar' }, { nom: 'Supermercat' }, { nom: 'Souvenirs' }, { nom: 'Joguines' }, { nom: 'Altres' }])
classes_entreteniment = ClasseEntreteniment.create([{ nom: 'Bolera' }, { nom: 'Cinema' }, { nom: 'Teatre' }, { nom: 'Gimnàs' }, { nom: 'Spa-Balneari' }, { nom: 'Altres' }])
classes_museus = ClasseMuseu.create([{ nom: 'Art' }, { nom: 'Ciències naturals' }, { nom: 'Ciències' }, { nom: 'Arqueològics' }, { nom: 'Història' }, { nom: 'Militar' }, { nom: 'Esportiu' }, { nom: 'Marítim' }, { nom: 'Altres' }])
classes_restaurant = ClasseRestaurant.create([{ nom: 'Xinès' }, { nom: 'Italià' }, { nom: 'Francès' }, { nom: 'Americà' }, { nom: 'Mediterrani' }, { nom: 'Indi' }, { nom: 'Tailandès' }, { nom: 'Japonès' }, { nom: 'Argentí' }, { nom: 'Altres' }])

paisos = Pais.create([{ nom: 'Espanya' }, { nom: 'França' }, { nom: 'Italia' }, { nom: 'Portugal' }, { nom: 'Suècia' }, { nom: 'Estats Units' }, { nom: 'Dinamarca' }])


