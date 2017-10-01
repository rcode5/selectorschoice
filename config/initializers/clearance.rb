# frozen_string_literal: true

Clearance.configure do |config|
  config.mailer_sender = 'no-reply@bunnymatic.com'
  config.allow_sign_up = false
  config.rotate_csrf_on_sign_in = true
end
