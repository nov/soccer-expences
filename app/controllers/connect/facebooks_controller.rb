class Connect::FacebooksController < ApplicationController
  before_filter :require_anonymous_access

  def create
    authenticate Connect::Facebook.authenticate(cookies)
    logged_in!
  end
end
