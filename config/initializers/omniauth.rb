Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "mblIrUeqpwgTkFPA5VHqlUHxJ", "aM6DSRM3fUongzln5HNq6eWpARtsri1h7D5WmGg3ZZglYXuWb3"
  provider :facebook, '501689603264204', '8370f5bb0f4c0ceaca3b82c51841475d'
  provider :gplus, '67111021803-l8he42vmvfhjqidup3mrrb4jiupotbfs.apps.googleusercontent.com', 'SDRMk6yo2MqbVqnyGTtmQtWy'
end
