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
      expect(page).to_not have_selector 'textarea'
    end

    expect(page).to_not have_content answer.body
  end

  scenario 'Author trying to edit answer and delete attachment', js: true do
    login_from_form(user)

    visit question_path(answer.question)

    fill_in 'answer_body', with: 'nothing to tell you.'
    attach_file 'Attachment', "#{Rails.root}/spec/spec_helper.rb"
    click_button 'Give answer'

    expect(current_path).to eq question_path(answer.question)
    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/attachment/1/spec_helper.rb'
      expect(page).to have_content 'nothing to tell you.'
      click_on "Edit"
      fill_in 'answer_body', with: 'answer.body answer.body answer.body'
      click_on 'remove'
      click_button 'Edit answer'

      expect(page).to have_content 'answer.body answer.body answer.body'
      
      expect(page).to_not have_selector 'textarea'

      expect(page).not_to have_content 'spec_helper.rb'
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