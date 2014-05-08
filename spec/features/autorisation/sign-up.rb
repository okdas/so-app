require 'spec_helper'


feature 'signing up', %q{
  In order to be able to log in
  As an visitor
  I want to be able to sign up
} do
  scenario 'with valid information' do
    visit new_user_registration_path

    fill_in 'Name', with: 'JonSnow'
    fill_in 'Email', with: 'jon-snow@winterfell.com'
    fill_in 'Password', with: 'winterIsComing'
    fill_in 'Password confirmation', with: 'winterIsComing'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome'
  end

  scenario 'with invalid name' do
    visit new_user_registration_path

    fill_in 'Name', with: 'x'
    fill_in 'Email', with: 'jon-snow@winterfell.com'
    fill_in 'Password', with: 'winterIsComing'
    fill_in 'Password confirmation', with: 'winterIsComing'
    click_button 'Sign up'

    expect(page).to have_content 'Name must be more than 2 characters'
  end
end