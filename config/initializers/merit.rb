# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  # config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'
  config.add_observer 'ReputationChangeObserver'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
   config.user_model_name = 'Usuari'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
   config.current_user_method = 'usuari_actual'
end

# Create application badges (uses https://github.com/norman/ambry)
# badge_id = 0
# [{
#   id: (badge_id = badge_id+1),
#   name: 'just-registered'
# }, {
#   id: (badge_id = badge_id+1),
#   name: 'best-unicorn',
#   custom_fields: { category: 'fantasy' }
# }].each do |attrs|
#   Merit::Badge.create! attrs
# end


 badge_id = 0
 [
 {
   id: (badge_id = badge_id+1),
   name: 'primer-pdi'
 },
 {
   id: (badge_id = badge_id+1),
   name: '10-pdis'
 },
 {
   id: (badge_id = badge_id+1),
   name: 'primera-ruta-turistica'
 },
 {
   id: (badge_id = badge_id+1),
   name: '3-rutes-turistiques'
 },
 {
   id: (badge_id = badge_id+1),
   name: 'primera-valoracio'
 },
 {
   id: (badge_id = badge_id+1),
   name: '5-valoracions'
 },
 {
   id: (badge_id = badge_id+1),
   name: 'registrat'
 }
 ].each do |attrs|
   Merit::Badge.create! attrs
 end