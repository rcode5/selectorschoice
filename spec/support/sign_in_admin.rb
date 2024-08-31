# frozen_string_literal: true

module SignInAdmin
  shared_context 'admin logged in' do
    let(:admin) do
      FactoryBot.create(:user)
    end
    before do
      visit sign_in_path
      fill_in :session_email, with: admin.email
      fill_in :session_password, with: 'password'
      click_on 'Sign in'
    end
  end
end
