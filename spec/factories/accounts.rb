FactoryBot.define do
  factory :account do
    sequence(:display_name) { |i| "Account##{i}" }
    sequence(:email) { |i| "account#{i}@example.com" }

    trait :admin do
      admin true
      approved true
    end

    trait :approved do
      admin false
      approved true
    end
  end
end
