class Event < ActiveRecord::Base
  validates :title, :location, :date, presence: true
end
