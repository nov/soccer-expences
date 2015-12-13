class MembersController < ApplicationController
  before_filter :require_admin_access, except: [:index, :show]

  def index
    @members = Member.all
  end

  def create

  end
end
