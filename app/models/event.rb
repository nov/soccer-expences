class Event < ActiveRecord::Base
  has_many :event_members
  has_many :members, through: :event_members

  validates :title, :location, :date, presence: true
  validates :cost_from_members_budget, :cost_from_team_budget, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  after_initialize :setup_date

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
      total_cost.to_f / total_attendees
    end
  end
end
