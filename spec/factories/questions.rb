# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :title do |n|
    "My question number #{n}"
  end

  sequence :body do |n|
    "Lorem ipsum #{n} dolor sit amet, consectetur adipiscing elit."
  end

  factory :question do
    title
    body
  end

  factory :invalid_question, class: 'Question' do
    title 'NoN'
    body 'nil'
  end

  factory :static_question, class: 'Question' do
    title 'My question number nil'
    body 'Donec vestibulum faucibus est, vitae tristique erat sollicitudin vitae.'
    association :user, factory: :user, strategy: :build
  end
end
