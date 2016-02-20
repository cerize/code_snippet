FactoryGirl.define do
  factory :kind do
    sequence(:name)   { |n| "#{Faker::Company.bs}-#{n}"}
  end
end
