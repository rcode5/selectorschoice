require 'clearance/rspec'

# use this helper for request specs
def sign_in_via_post(email)
  u = FactoryGirl.create(:user, :email => email)
  post '/session', session: { email: u.email, password: u.password }
end

# use this helper for controller specs
def sign_in_with_email(email)
  u = User.where(email: email)
  if u.empty?
    u = FactoryGirl.create(:user, :email => email)
  end
  sign_in_as u
  u
end
