require 'acceptance/acceptance_helper'

feature 'Vote for question', %q{
  As an aunthenticated user
  I want to be able to upvote and downvote questions
} do
  given(:user) { create :user }
  given(:question) { create :static_question }
  scenario 'Authenticated user trying to upvote question', js: true do
    login_from_form(user)
    visit question_path question

    within '.question .votecount' do
      expect(page).to have_content '0'
    end

    click_on 'Vote up'

    within '.question .votecount' do
      expect(page).to have_content '1'
    end
  end
  scenario 'Not authenticated user trying to vote question' do
    visit question_path question

    within '.question .vote' do
      expect(page).not_to have_content 'Vote down'
      expect(page).not_to have_content 'Vote up'
    end
  end

  scenario 'Authenticated user trying to downvote question', js: true do
    login_from_form(user)
    visit question_path question

    within '.question .votecount' do
      expect(page).to have_content '0'
    end

    click_on 'Vote down'

    within '.question .votecount' do
      expect(page).to have_content '-1'
    end
  end
end