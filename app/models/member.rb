class Member < ActiveRecord::Base
  has_many :event_members
  has_many :events, through: :event_members

  validates :display_name, :initial_budget, :remaining_budget, :spent_budget, presence: true
  validates :display_name, uniqueness: true
  validates :initial_budget, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  validates :spent_budget, numericality: {
    greater_than_or_equal_to: 0.0
  }
  after_initialize :setup_budget

  def setup_budget
    self.initial_budget ||= 5000
    self.spent_budget ||= 0
  end

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
  end
end
