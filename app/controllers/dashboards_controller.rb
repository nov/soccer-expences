class DashboardsController < ApplicationController
  skip_before_filter :require_approved_access
  before_filter :require_authentication

  def show
    @events = Event.order(date: :desc).all
  end
end
