require 'acceptance/acceptance_helper'

feature 'asking question', %q{
  In order to get answer
  As an a registered person
  I want to be able to ask question
} do
  given(:user) { create :user }
  scenario 'Registered user trying to ask a question' do
    login_from_form(user)

    visit new_question_path

    fill_in 'Title', with: 'My question number nil'
    fill_in 'Question', with: 'Donec vestibulum faucibus est, vitae tristique erat sollicitudin vitae.'

    click_button 'Ask question'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Unregistered user trying to ask question' do
    visit new_question_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end