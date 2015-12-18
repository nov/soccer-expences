require 'rails_helper'

RSpec.describe Member, type: :model do
  let(:events) do
    10.times.collect do
      create(:event, :with_random_cost)
    end
  end

  describe '#calculate_spent_budget' do
    let(:member) { create(:member) }
    let(:attended_events) { events.sample(rand(1..10)) }

    it 'should update spent_budget based on all attended events' do
      attended_events.each do |event|
        member.events << event
      end
      member.spent_budget.should == 0
      member.calculate_spent_budget
      member.reload.spent_budget.should == attended_events.sum(&:cost_per_member)
    end
  end

  describe '.calculate_spent_budget' do
    it :TODO
  end
end
