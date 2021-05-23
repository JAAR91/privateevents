class Event < ApplicationRecord
  belongs_to :user
  has_many :attendees, dependent: :destroy

  scope :upcoming_events, -> { where('date >= ?', Date.today) }
  scope :past_events, -> { where('date < ?', Date.today) }
end
