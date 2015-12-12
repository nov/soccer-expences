class ApplicationController < ActionController::Base
  include Authentication

  protect_from_forgery with: :exception

  before_filter :optional_authentication
end
