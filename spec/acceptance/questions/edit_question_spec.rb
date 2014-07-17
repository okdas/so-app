require 'acceptance/acceptance_helper'

feature 'asking question', %q{
  As an a registered person
  I want to be able to edit my question
} do
  given(:user) { create :user }
  given(:question) { create :static_question }

  scenario 'Author trying to edit his own question' do
    login_from_form(question.user)

    visit question_path(question)

    click_on 'Edit question'

    fill_in 'Title', with: 'My question edited title'
    fill_in 'Question', with: 'My question edited body. Nullam ut varius neque. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum eu lectus lorem.'
    fill_in 'Tag list', with: 'secondtag'

    click_on 'Edit question'
    expect(current_path).to eq question_path(question)
    expect(page).to have_link 'secondtag', href: '/tagged?tag=secondtag'
    expect(page).to have_content 'Question was successfully updated.'
    expect(page).to_not have_content 'defaultTag'
  end


  scenario 'Author trying to add and delete attachment', js: true do
    login_from_form(question.user)

    visit question_path(question)

    click_on 'Edit question'

    click_on 'add'
    attach_file 'Attachment', "#{Rails.root}/spec/spec_helper.rb"

    click_button 'Edit question'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/attachment/1/spec_helper.rb'
    expect(page).to have_content 'Question was successfully updated.'

    click_on 'Edit question'
    click_on '- remove'
    click_on 'Edit question'
    expect(page).to_not have_content 'spec_helper.rb'

  end

  scenario 'Author user trying to edit foreign question' do
    login_from_form(user)

    visit question_path(question)

    expect(page).not_to have_content 'Edit question'

    expect{visit edit_question_path(question)}.to raise_error(CanCan::AccessDenied)
  end

  scenario 'Unregistered user trying to edit question' do
    visit edit_question_path(question)
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end