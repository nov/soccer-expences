require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#total_attendees' do
    it 'should be counter cache' do
      event = create(:event)
      event.total_attendees.should == 0
      3.times { event.members << create(:member) }
      event.total_attendees.should == 3
      event.members.destroy Member.last
      event.reload.total_attendees.should == 2
    end
  end

  describe '#cost_per_member' do
    it 'should be total_cost / total_attendees' do
      event = create(
        :event,
        cost_from_members_budget: 1200,
        cost_from_team_budget: 500
      )
      3.times { event.members << create(:member) }
      event.cost_per_member.should == 1700.0 / 3
    end
  end

  describe '#calculate_spent_budget' do
    it 'should be called when updated' do
      event = create(:event, cost_from_members_budget: 100)
      event.should receive :calculate_spent_budget
      event.update cost_from_members_budget: 1000
    end

    it 'should re-calculate for all attendees' # TODO
  end
end
