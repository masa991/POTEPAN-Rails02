class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :rooms
  has_many :reservations

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, length: { maximum: 200 }, presence: true

  mount_uploader :image, ImageUploader 
end
