class Event < ActiveRecord::Base
  validates :title, :location, :date, presence: true
  after_initialize :setup_date

  def setup_date
    self.date ||= Date.today
  end
end
