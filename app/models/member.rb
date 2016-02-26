class Member < ActiveRecord::Base
  has_many :event_members
  has_many :events, through: :event_members

  validates :display_name, :initial_budget, :spent_budget, presence: true
  validates :display_name, uniqueness: true
  validates :initial_budget, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  validates :spent_budget, numericality: {
    greater_than_or_equal_to: 0.0
  }

  def remaining_budget
    (initial_budget - spent_budget).to_i
  end

  def calculate_spent_budget
    self.spent_budget = events.to_a.sum(&:cost_per_member)
    save
  end

  class << self
    def calculate_spent_budget
      includes(:events).collect(&:calculate_spent_budget)
    end

    def total_initial_budget
      all.to_a.sum(&:initial_budget)
    end

    def total_remaining_budget
      total_initial_budget - Event.total_cost_from_members_budget
    end

    def total_refundable_budget
      all.to_a.sum(&:remaining_budget)
    end
  end
end
