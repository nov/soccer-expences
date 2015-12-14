class Member < ActiveRecord::Base
  validates :display_name, :initial_budget, :remaining_budget, presence: true
  validates :display_name, uniqueness: true
  validates :initial_budget, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0.0
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
end
