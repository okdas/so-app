# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Jon Snow'
    email 'jon-snow@winterfell.com'
    password 'winterIsComing'
  end
end
