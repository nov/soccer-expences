FactoryGirl.define do
  factory :event do
    sequence(:title) { |i| "Event##{i}" }
    sequence(:location) { |i| "Location##{i}" }
    sequence(:date) { |i| i.days.ago.to_date }

    trait :with_random_cost do
      cost_from_members_budget { rand(100..5000) }
      cost_from_team_budget { rand(100..5000) }
    end
  end
end
