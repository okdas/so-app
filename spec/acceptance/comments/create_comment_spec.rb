require 'spec_helper'

feature 'creating comment', %q{
  To get feedback
  As an authenticated user
  I want to be able to comment answer
} do
  given(:answer) { create :answer }

  scenario 'Authenticated user trying to comment answer' do
    login_as(answer.user, scope: :user)

    visit question_path(answer.question)

    fill_in 'comment_body', with: 'Nothing interesting there. Just comment.'
    click_on 'Comment'

    expect(current_path).to eq question_path(answer.question)

    within '.comments' do
      expect(page).to have_content 'Nothing interesting there. Just comment.'
    end
  end

  scenario 'Not authenticated user trying to comment answer'
end