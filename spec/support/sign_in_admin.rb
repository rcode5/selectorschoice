# frozen_string_literal: true

module SignInAdmin
  shared_context 'admin logged in' do
    let(:password) { SecureRandom.uuid }
    let(:admin) { FactoryBot.create(:user, password:) }
    before do
      visit sign_in_path
      fill_in :session_email, with: admin.email
      fill_in :session_password, with: password
      click_on 'Sign in'
    end
  end
end
