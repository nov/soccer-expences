class DashboardsController < ApplicationController
  skip_before_filter :require_approved_access, only: :show
  before_filter :require_authentication

  def show
    @events = Event.order(date: :desc).all
  end

  def update
    Member.calculate_spent_budget
    redirect_to members_url, flash: {
      success: 'message.spent_budget_recalculated'.t
    }
  end
end
