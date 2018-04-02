class SessionsController < ApplicationController
  skip_before_action :require_approved_access
  before_action :require_authentication

  def destroy
    unauthenticate!
    redirect_to root_url
  end
end
