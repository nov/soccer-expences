class EventMember < ActiveRecord::Base
  belongs_to :event
  belongs_to :member

  class << self
    def toggle(member)
      context = where(member: member)
      if (attendance = context.first).present?
        attendance.destroy and :canceled
      else
        context.create and :attended
      end
    end
  end
end
