class Event::MembersController < ApplicationController
  before_action :require_admin_access, except: :index
  before_action :require_event_context
  before_action :set_member, except: :index

  def index
    render json: @event.members.as_json
  end

  def update
    if @event.members.include? @member
      @event.members.destroy @member
      render json: {status: :canceled}
    else
      @event.members << @member
      render json: {status: :attended}
    end
  end

  private

  def set_member
    @member = Member.find params[:id]
  end
end
