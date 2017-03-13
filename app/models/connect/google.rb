class Connect::Google < ActiveRecord::Base
  belongs_to :account
  validates :identifier, :access_token, null: false
  validates :identifier, uniqueness: true

  class << self
    def config
      Rails.application.secrets[:google].with_indifferent_access
    end

    def client
      @client ||= OpenIDConnect::Client.new(
        identifier: config[:client_id],
        secret: config[:client_secret],
        token_endpoint: 'https://www.googleapis.com/oauth2/v4/token',
        userinfo_endpoint: 'https://www.googleapis.com/oauth2/v3/userinfo',
        redirect_uri: 'postmessage'
      )
    end

    def authenticate(code)
      client.authorization_code = code
      token_response = client.access_token!
      id_token = JSON::JWT.decode token_response.id_token, :skip_verification
      connect = find_or_initialize_by(identifier: id_token[:sub])
      connect.access_token = token_response.access_token
      connect.save!
      if connect.account.present?
        connect.account
      else
        userinfo = token_response.userinfo!
        Account.create!(
          google: connect,
          email: userinfo.email,
          display_name: userinfo.name
        )
      end
    end
  end
end
