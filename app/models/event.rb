class Event < ActiveRecord::Base
  has_many :event_members
  has_many :members, through: :event_members

  validates :title, :location, :date, :cost_from_members_budget, :cost_from_team_budget, presence: true
  validates :cost_from_members_budget, :cost_from_team_budget, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  after_initialize :setup_date
  after_update :calculate_spent_budget

  def setup_date
    self.date ||= Date.today
  end

  def total_attendees
    event_members_count
  end

  def total_cost
    cost_from_members_budget + cost_from_team_budget
  end

  def cost_per_member
    if total_attendees == 0
      0
    else
      cost_from_members_budget.to_f / total_attendees
    end
  end

  def calculate_spent_budget
    members.includes(:events).collect(&:calculate_spent_budget)
  end
end
