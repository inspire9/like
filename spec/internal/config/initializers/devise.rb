Devise.setup do |config|
  config.secret_key = 'aa5e96a76400191fc1f76c44a6c3e0f4f37d9097be933fa5280c25fd3111ab9382d5a72c5a6879ebf0bfce62e18d5eabd5121fd2ef3bb8df49521f6e257223ac'

  config.mailer_sender = 'pat@test.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = 1
  config.allow_unconfirmed_access_for = 1.day
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
