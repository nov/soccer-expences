class Connect::FacebooksController < ApplicationController
  skip_before_filter :require_approved_access
  before_filter :require_anonymous_access

  def create
    authenticate Connect::Facebook.authenticate(cookies)
    logged_in!
  rescue ActiveRecord::RecordInvalid
    redirect_to root_url, flash: {
      warning: 'FB Permission Missing'
    }
  rescue FbGraph2::Auth::SignedRequest::VerificationFailed
    redirect_to root_url, flash: {
      warning: 'FB Login Failed'
    }
  end
end
