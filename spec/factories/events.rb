FactoryGirl.define do
  factory :event do
    sequence(:title) { |i| "Event##{i}" }
    sequence(:location) { |i| "Location##{i}" }
    sequence(:date) { |i| i.days.ago.to_date }
  end
end
