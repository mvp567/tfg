class ReputationChangeObserver
  def update(changed_data)
    description = changed_data[:description]

    # If user is your meritable model, you can query for it doing:
    user = Usuari.where(sash_id: changed_data[:merit_object][:sash_id]).first
    # When did it happened:
    datetime = changed_data[:merit_object][:created_at]
    #http://stackoverflow.com/questions/21924614/rails-merit-gem-how-to-display-timeline-of-reputation-changes
    
   #include MyConcernModule
  end
end