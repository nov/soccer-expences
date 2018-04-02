class Connect::GooglesController < ApplicationController
  skip_before_action :require_approved_access
  before_action :require_anonymous_access

  def create
    authenticate Connect::Google.authenticate(params[:code])
    logged_in!
  rescue => e
    redirect_to root_url, flash: {
      warning: 'Google Login Failed'
    }
  end
end
