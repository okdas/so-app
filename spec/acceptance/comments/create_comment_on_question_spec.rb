require 'acceptance/acceptance_helper'

feature 'creating comment', %q{
  To get feedback
  As an authenticated user
  I want to be able to comment answer
} do
  given(:question) { create :question }
  given(:user) { create :user }

  scenario 'Authenticated user trying to comment answer', js: true do
    login_from_form(user)

    visit question_path(question)

    click_on 'Comment question'
    fill_in 'comment_body', with: 'Nothing interesting there. Just comment.'
    click_button 'Add comment'

    expect(current_path).to eq question_path(question)

    within '.question-comments' do
      expect(page).to have_content 'Nothing interesting there. Just comment.'
    end
  end

  scenario 'Not authenticated user trying to comment answer' do
    visit question_path(question)
    click_on 'Comment question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end