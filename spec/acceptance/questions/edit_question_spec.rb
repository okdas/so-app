require 'spec_helper'

feature 'asking question', %q{
  As an a registered person
  I want to be able to edit my question
} do
  given(:user) { create :user }
  given(:question) { create :static_question }
  scenario 'Registered user trying to edit his own question' do
    login_as(user, scope: :user)

    visit new_question_path

    fill_in 'Title', with: 'My question number nil'
    fill_in 'Question', with: 'Donec vestibulum faucibus est, vitae tristique erat sollicitudin vitae.'

    click_button 'Ask question'

    click_on 'Edit question'

    fill_in 'Title', with: 'My question edited title'
    fill_in 'Question', with: 'My question edited body. Nullam ut varius neque. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum eu lectus lorem.'

    click_on 'Edit question'

    expect(page).to have_content 'Your question successfully edited.'
  end

  scenario 'Registered user trying to edit foreign question' do
    login_as(user, scope: :user)

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