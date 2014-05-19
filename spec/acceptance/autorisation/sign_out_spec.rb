require 'acceptance/acceptance_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature 'signing out', %q{
  In order to be a visitor
  As signed in user
  I want to be able to sign out
} do
  given(:user) { create(:user) }
  scenario 'Existing user trying to sign out' do
    login_as(user, scope: :user)

    visit root_path

    page.driver.submit :delete, destroy_user_session_path, {}

    expect(page).to have_content('Signed out successfully.')
  end
end