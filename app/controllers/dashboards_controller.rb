class DashboardsController < ApplicationController
  skip_before_action :require_approved_access, only: :show
  before_action :require_authentication

  def show
    @events = Event.order(date: :desc)
  end

  def update
    Member.calculate_spent_budget
    redirect_to members_url, flash: {
      success: 'message.spent_budget_recalculated'.t
    }
  end
end
