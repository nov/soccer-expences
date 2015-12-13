class MembersController < ApplicationController
  before_filter :require_approved_access
  before_filter :require_admin_access, only: :create

  def index
    @members = Member.all
  end

  def create

  end
end
