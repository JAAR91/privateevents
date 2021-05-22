class Event < ApplicationRecord
  belongs_to :user
  has_many :attendees, dependent: :destroy
end
