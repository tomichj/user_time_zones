FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
  end

  trait :pacific_time_zone do
    time_zone 'Pacific Time (US & Canada)'
  end
end
