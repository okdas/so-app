require 'acceptance/acceptance_helper'

feature 'Question search', %q{
  In order to get answer for already existing question
  As a visitor
  I want to search question
} do

  given!(:question) { create :question }

  scenario 'Visitor search for existing question', js: true do
    ThinkingSphinx::Test.index 'question_core'

    visit search_index_path(search: 'Lorem ipsum')

    within '.search-result' do
      expect(page).to have_content "My question number"
    end
  end

  scenario 'Visitor search for not existing question', js: true do
    ThinkingSphinx::Test.index 'question_core'

    visit search_index_path(search: 'NO QUESTION LIKE THAT')

    within '.search-result' do
      expect(page).to_not have_content "My question number"
    end
  end
end