FactoryGirl.define do
  factory :connect_facebook, class: 'Connect::Facebook' do
    identifier SecureRandom.random_number(1 << 64)
    access_token SecureRandom.hex(64)
    account
  end
end
