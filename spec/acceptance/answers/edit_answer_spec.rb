require 'acceptance/acceptance_helper'

feature 'Answer editing', %q{
  In order to change my opinion (lold)
  As an answer's author
  I want to edit my answer
} do
  given(:answer) { create :answer }
  given(:user) { create :user }

  scenario 'Author trying to edit answer', js: true do
    login_from_form(answer.user)

    visit question_path(answer.question)

    click_on "Edit"

    within "#answer#{answer.id}" do
      fill_in 'answer_body', with: 'answer.body answer.body answer.body'
      click_button 'Edit answer'
      expect(page).to have_content 'answer.body answer.body answer.body'
    end
  end

  scenario 'Authenticated user trying to edit foreign answer' do
    login_from_form(user)

    visit question_path(answer.question)

    within '.answers' do
      expect(page).to_not have_content 'Edit'
    end
  end

  scenario 'Unauthenticated user trying to edit answer', js: true do
    visit question_path(answer.question)
    expect(page).to_not have_link 'Edit answer'
  end
end