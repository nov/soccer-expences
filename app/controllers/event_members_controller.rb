class EventMembersController < ApplicationController
  before_filter :require_admin_access, except: :index
  before_filter :set_event
  before_filter :set_member, except: :index

  def index
    render json: @event.members.as_json
  end

  def update
    if status = @event.event_members.toggle(@member)
      render json: {status: status}
    else
      render json: {status: 'error'}, status: 400
    end
  end

  private

  def set_event
    @event = Event.find params[:event_id]
  end

  def set_member
    @member = Member.find params[:id]
  end
end
