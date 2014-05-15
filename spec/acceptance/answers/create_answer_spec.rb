require 'spec_helper'

feature 'giving answer', %q{
  As an an authenticated person
  I want to be able to give answer
} do
  given(:user) { create :user }
  given(:question) { create :question }
  scenario 'Authenticated user trying to create answer', js: true do
    login_as(user, scope: :user)

    visit question_path(question)

    fill_in 'answer_body', with: 'nothing to tell you.'
    click_button 'Give answer'

    expect(current_path).to eq question_path(question)

    within '.answers' do
      expect(page).to have_content 'nothing to tell you.'
    end

  end
end