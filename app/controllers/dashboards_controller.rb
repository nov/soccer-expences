class DashboardsController < ApplicationController
  before_filter :require_authentication

  def show
    @events = Event.all
  end
end
