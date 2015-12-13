class TopController < ApplicationController
  skip_before_filter :require_approved_access
  before_filter :require_anonymous_access

  def index
  end
end
