class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations

  validates :room_name, presence: true
  validates :room_introduction, length: { maximum: 200 }, presence: true
  validates :fee, presence: true, numericality: true
  validates :address, presence: true
  validates :room_image, presence: true

  mount_uploader :room_image, ImageUploader
end
