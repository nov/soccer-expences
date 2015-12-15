module Concerns
  module ResourceContext
    extend ActiveSupport::Concern

    included do
      # nothing to do
    end

    def require_account_context
      @account = Account.find params[:account_id]
    end

    def require_event_context
      @event = Event.find params[:event_id]
    end
  end
end