FactoryBot.define do
  factory :connect_google, class: 'Connect::Google' do
    identifier SecureRandom.random_number(1 << 64)
    access_token SecureRandom.hex(64)
    account
  end
end
