class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :attendees, dependent: :destroy

  scope :upcoming_events, -> { where('date >= ?', Date.today) }
  scope :past_events, -> { where('date < ?', Date.today) }
end
