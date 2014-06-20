# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "jon-snow.#{n}@winterfell.com"
  end

  factory :user do
    name 'Jon Snow'
    email
    password 'winterIsComing'
  end

  factory :static_user do
    name 'Valar Morghulis'
    email 'ceo@morghulis.net'
    password 'valardohaeris'
  end
end
