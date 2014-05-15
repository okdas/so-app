require 'spec_helper'

feature 'signing in', %q{
  In order to be able ask questions
  As an user
  I want to be able to login
} do
  given(:user) { create(:user) }

  scenario 'Existing user trying to log in' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Sign in'

    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'Unregistered user trying to log in' do
    visit new_user_session_path
    fill_in 'Email', with: 'khaleesi@dotraki.net'
    fill_in 'Password', with: 'whereIsMyDragons?'

    click_button 'Sign in'

    expect(page).to have_content('Invalid email or password.')
  end

end