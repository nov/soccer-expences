class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery with: :exception
  before_filter :require_approved_access
end
