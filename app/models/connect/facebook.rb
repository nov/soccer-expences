require 'url_safe_base64'

class Connect::Facebook < ActiveRecord::Base
  belongs_to :account

  def picture(type = :square)
    [
      File.join(FbGraph2.root_url, identifier, 'picture'),
      {type: type}.to_query
    ].join('?')
  end

  def profile
    @profile ||= FbGraph2::User.me(access_token).fetch(
      fields: [:name, :email]
    )
  end

  class << self
    def config
      Rails.application.secrets[:facebook].with_indifferent_access
    end

    def auth
      FbGraph2::Auth.new config[:client_id], config[:client_secret]
    end

    def authenticate(cookies)
      _auth_ = auth.from_cookie cookies
      connect = find_or_initialize_by(identifier: _auth_.user.identifier)
      connect.access_token = _auth_.access_token.access_token
      connect.save!
      connect.account || Account.create!(
        facebook: connect,
        email: connect.profile.email,
        display_name: connect.profile.name
      )
    end
  end
end
