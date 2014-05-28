require 'acceptance/acceptance_helper'

feature 'asking question', %q{
  As an a registered person
  I want to be able to edit my question
} do
  given(:user) { create :user }
  given(:question) { create :static_question }

  scenario 'Author trying to edit his own question' do
    login_from_form(question.user)

    visit question_path(question)

    click_on 'Edit question'

    fill_in 'Title', with: 'My question edited title'
    fill_in 'Question', with: 'My question edited body. Nullam ut varius neque. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum eu lectus lorem.'

    click_on 'Edit question'

    expect(page).to have_content 'Your question successfully edited.'
  end


  scenario 'Author trying to edit his own question and delete attachment', js: true do
    login_from_form(user)

    visit new_question_path

    fill_in 'Title', with: 'My question number nil'
    fill_in 'Question', with: 'Donec vestibulum faucibus est, vitae tristique erat sollicitudin vitae.'
    attach_file 'Attachment', "#{Rails.root}/spec/spec_helper.rb"

    click_button 'Ask question'

    expect(page).to have_content 'Your question successfully created.'

    visit question_path(user.questions.first)

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/attachment/1/spec_helper.rb'

    visit edit_question_path(user.questions.first)

    click_on 'remove'
    click_on 'Edit question'


  end

  scenario 'Author user trying to edit foreign question' do
    login_from_form(user)

    visit question_path(question)

    expect(page).not_to have_content 'Edit question'

    visit edit_question_path(question)

    expect(page).to have_content 'This is not your question.'
  end

  scenario 'Unregistered user trying to edit question' do
    visit edit_question_path(question)
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end