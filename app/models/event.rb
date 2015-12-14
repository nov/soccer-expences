class Event < ActiveRecord::Base
  has_many :event_members
  has_many :members, through: :event_members

  validates :title, :location, :date, presence: true
  after_initialize :setup_date

  alias_method :attendance, :event_members

  def setup_date
    self.date ||= Date.today
  end
end
