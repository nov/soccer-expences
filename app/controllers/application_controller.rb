class ApplicationController < ActionController::Base
  include Authentication
  include Concerns::ResourceContext
  protect_from_forgery with: :exception
  before_action :require_approved_access
end
