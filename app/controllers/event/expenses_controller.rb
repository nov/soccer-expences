class Event::ExpensesController < ApplicationController
  before_action :require_admin_access, except: :index
  before_action :require_event_context

  def update
    Member.calculate_spent_budget
    redirect_to event_url(@event)
  end
end
