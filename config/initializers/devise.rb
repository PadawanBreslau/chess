Devise.setup do |config|
  config.secret_key = '686af73691a37297dfa424ad8c7c95a07744de8eecc4cad2c95bb5ae40ebc6450a0084fe6200567228d02e903d4ca04e65dc6052c426309c876c0d30e1e3a6e3'

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.password_length = 6..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
