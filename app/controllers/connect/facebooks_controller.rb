class Connect::FacebooksController < ApplicationController
  skip_before_filter :require_approved_access
  before_filter :require_anonymous_access

  def create
    authenticate Connect::Facebook.authenticate(cookies)
    logged_in!
  end
end
