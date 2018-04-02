FactoryBot.define do
  factory :member do
    sequence(:display_name) { |i| "Member##{i}" }
  end
end
