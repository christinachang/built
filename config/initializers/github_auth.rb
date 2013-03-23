Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'a039b57388ce5d8626ca', '1501701b91d8e7b80f0990f7513363e5503dfc30'
end
