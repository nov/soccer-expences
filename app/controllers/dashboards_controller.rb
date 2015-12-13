class DashboardsController < ApplicationController
  before_filter :require_authentication

  def show
    @events = Event.order(date: :desc).all
  end
end
