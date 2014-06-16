Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "mblIrUeqpwgTkFPA5VHqlUHxJ", "aM6DSRM3fUongzln5HNq6eWpARtsri1h7D5WmGg3ZZglYXuWb3"
  provider :facebook, ENV['501689603264204'], ENV['8370f5bb0f4c0ceaca3b82c51841475d']
  provider :gplus, ENV['AIzaSyC4nMCVFo1EtVAfadAI_Udo77cSXJ-w3Nw'], ENV['wGYskXzBmykN88fT47pOxrkM']
end
