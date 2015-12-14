class MembersController < ApplicationController
  before_filter :require_admin_access, except: [:index, :show]
  before_filter :set_member, except: [:index, :new, :create]

  def index
    @members = Member.all
  end

  def show
    @events = @member.events.order(date: :desc)
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def create
    @member = Member.new member_params
    if @member.save
      redirect_to @member, flash: {
        success: 'flash.create.success'.t
      }
    else
      render :new
    end
  end

  def update
    if @member.update member_params
      redirect_to @member, flash: {
        success: 'flash.update.success'.t
      }
    else
      render :edit
    end
  end

  private

  def set_member
    @member = Member.find params[:id]
  end

  def member_params
    params.require(:member).permit(:display_name, :description, :initial_budget)
  end
end
