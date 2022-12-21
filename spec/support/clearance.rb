# frozen_string_literal: true

require 'clearance/rspec'

# use this helper for request specs
def sign_in_via_post(email)
  u = FactoryBot.create(:user, email:)
  post '/session', params: { session: { email: u.email, password: u.password } }
end

# use this helper for controller specs
def sign_in_with_email(email)
  u = User.where(email:)
  u = FactoryBot.create(:user, email:) if u.empty?
  sign_in_as u
  u
end
