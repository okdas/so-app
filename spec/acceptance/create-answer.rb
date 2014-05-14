require 'spec_helper'

feature 'giving answer', %q{
 TODO: tracker
} do
  given(:user) { create :user }
  given(:question) { create :question }
  scenario 'Authenticated user trying to create answer', js: true do
    login_as(user, scope: :user)

    visit question_path(question)

    fill_in 'Your answer', with: 'nothing to tell you.'
    click_button 'Give answer'

    expect(current_path).to eq question_path(question)

    save_and_open_page

    within '.answers' do
      expect(page).to have_content 'nothing to tell you.'
    end

  end
end