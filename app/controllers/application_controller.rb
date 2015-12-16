class ApplicationController < ActionController::Base
  include Authentication
  include Concerns::ResourceContext
  protect_from_forgery with: :exception
  before_filter :require_approved_access
  after_filter :action_logging

  def action_logging
    if Rails.env.staging?
      Keen.publish "#{controller_name}##{action_name}", {
        current_account: current_account.id,
      }
    end
  end
end
