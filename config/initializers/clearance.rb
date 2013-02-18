Clearance.configure do |config|
  config.mailer_sender = 'jon@bunnymatic.com'
  config.cookie_expiration = lambda { 1.year.from_now.utc }
end
