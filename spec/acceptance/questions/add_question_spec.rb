require 'acceptance/acceptance_helper'

feature 'asking question', %q{
  In order to get answer
  As an a registered person
  I want to be able to ask question
} do
  given(:user) { create :user }
  scenario 'Registered user trying to ask a question', js: true do
    login_from_form(user)

    visit new_question_path

    fill_in 'Title', with: 'My question number nil'
    fill_in 'Question', with: 'Donec vestibulum faucibus est, vitae tristique erat sollicitudin vitae.'
    page.execute_script "$('.tagsinput').importTags('freebsd,sql');"
    click_button 'Ask question'

    expect(page).to have_content 'Question was successfully created.'
    expect(page).to have_link 'freebsd', href: '/tagged?tag=freebsd'
    visit questions_path
    expect(page).to have_link 'sql', href: '/tagged?tag=sql'
  end

  scenario 'Registered user trying to ask a question with attached file', js: true do
    login_from_form(user)

    visit new_question_path

    fill_in 'Title', with: 'My question number nil'
    fill_in 'Question', with: 'Donec vestibulum faucibus est, vitae tristique erat sollicitudin vitae.'
    attach_file 'Attachment', "#{Rails.root}/spec/spec_helper.rb"

    click_button 'Ask question'

    expect(page).to have_content 'Question was successfully created.'
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/attachment/1/spec_helper.rb'
  end

  scenario 'Unregistered user trying to ask question' do
    visit new_question_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end