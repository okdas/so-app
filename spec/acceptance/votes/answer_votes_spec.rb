require 'acceptance/acceptance_helper'

feature 'Vote for question', %q{
  As an aunthenticated user
  I want to be able to upvote and downvote questions
} do
  given(:user) { create :user }
  given(:answer) { create :answer }
  scenario 'Authenticated user trying to upvote question', js: true do
    login_from_form(user)
    visit question_path answer.question

    within "#answer_#{answer.id}" do
      within '.votecount' do
        expect(page).to have_content '0'
      end

      click_on 'Vote up'

      within ".votecount" do
        expect(page).to have_content '1'
      end
    end
  end
  scenario 'Not authenticated user trying to vote question' do
    visit question_path answer.question

    within "#answer_#{answer.id} .vote" do
      expect(page).not_to have_content 'Vote down'
      expect(page).not_to have_content 'Vote up'
    end
  end

  scenario 'Authenticated user trying to downvote question', js: true do
    login_from_form(user)
    visit question_path answer.question

    within "#answer_#{answer.id}" do
      within '.votecount' do
        expect(page).to have_content '0'
      end

      click_on 'Vote down'

      within '.votecount' do
        expect(page).to have_content '-1'
      end
    end
  end
end