require 'acceptance/acceptance_helper'

feature 'Question search', %q{
  In order to get answer for already existing question
  As a visitor
  I want to search question
} do

  given(:question) { create :question }

  scenario 'Visitor search for existing question', js: true do
    visit root_path

    fill_in 'search', with: 'lorem ipsum'

    # Simulates 'Enter' hit
    page.execute_script("$('#search').submit()")

    expect(page).to have_content "My question number"
  end

end