class EventMember < ActiveRecord::Base
  belongs_to :event, counter_cache: true
  belongs_to :member

  class << self
    def toggle(member)
      context = where(member: member)
      if (event_member = context.first).present?
        event_member.destroy and :canceled
      else
        context.create and :attended
      end
    end
  end
end
