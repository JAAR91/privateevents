class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :attendees, dependent: :destroy

  scope :upcoming_events, -> { where('date >= ?', Date.today) }
  scope :past_events, -> { where('date < ?', Date.today) }

  validates :title, presence: true
  validates :description, presence: true
  validates :tpeople, presence: true
  validates :frequency, presence: true
  validates :eventtype, presence: true
  validates :eventcategory, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :creator_id, presence: true
end
