class TopController < ApplicationController
  skip_before_action :require_approved_access
  before_action :require_anonymous_access

  def index
  end
end
