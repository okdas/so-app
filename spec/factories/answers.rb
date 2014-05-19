# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    body "Ut tincidunt felis vitae ullamcorper euismod. Donec pretium velit est, vitae blandit ipsum tincidunt ut."
    association :question, factory: :question, strategy: :build
    association :user, factory: :user, strategy: :build
  end

  factory :invalid_answer, class: Answer do
    body nil
    question
    user
  end
end
