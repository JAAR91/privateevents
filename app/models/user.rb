class User < ApplicationRecord
  has_many :events, foreign_key: :creator_id, dependent: :destroy
  has_many :attendees

  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
end
