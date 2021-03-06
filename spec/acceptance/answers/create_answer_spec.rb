require 'acceptance/acceptance_helper'

feature 'giving answer', %q{
  In order to share my knowledge
  As an authenticated person
  I want to be able to give answer
} do
  given(:user) { create :user }
  given(:question) { create :question }
  scenario 'Authenticated user trying to create answer', js: true do
    login_from_form(user)

    visit question_path(question)
    fill_in 'answer_body', with: 'nothing to tell you.'
    click_button 'Give answer'

    expect(current_path).to eq question_path(question)

    within '.answers' do
      expect(page).to have_content 'nothing to tell you.'
    end
  end

  scenario 'Authenticated user trying to create answer with attachment', js: true do
    login_from_form(user)

    visit question_path(question)

    fill_in 'answer_body', with: 'nothing to tell you.'
    attach_file 'Attachment', "#{Rails.root}/spec/spec_helper.rb"
    click_button 'Give answer'

    expect(current_path).to eq question_path(question)

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/attachment/1/spec_helper.rb'
      expect(page).to have_content 'nothing to tell you.'
    end
  end

  scenario 'Authenticated user trying to create invalid answer', js: true do
    login_from_form(user)
    visit question_path(question)

    fill_in 'answer_body', with: ''
    click_button 'Give answer'

    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Not authenticated user trying to create answer' do
    visit question_path(question)
    expect(page).to have_content 'You need to sign in or sign up before commenting.'
  end
end