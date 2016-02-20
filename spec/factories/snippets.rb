FactoryGirl.define do
  factory :snippet do
    sequence(:title)  { |n| "#{Faker::Company.bs}-#{n}" }
    work   Faker::Lorem.paragraph
  end
end
