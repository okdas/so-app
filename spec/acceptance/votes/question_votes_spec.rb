include 'acceptance/acceptance_helper'

feature 'Vote for question', %q{
  As an aunthenticated user
  I want to be able to upvote and downvote questions
} do
  given(:user) { create :user }
  given(:question) { create :static_question }
  scenario 'Authenticated user trying to upvote question' do
    visit question_path question

    click_on '.upvote_question'

    within '.question .votecount' do
      expect(page).to have_content '1'
    end
  end
  scenario 'Not authenticated user trying to vote question'
  scenario 'Authenticated user trying to downvote question'
end