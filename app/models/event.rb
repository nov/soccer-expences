class Event < ActiveRecord::Base
  validates :title, :location, :date, presence: true
  validates :title, :location, length: { in: 6..25 }
end
