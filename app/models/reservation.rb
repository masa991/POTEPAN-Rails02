class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_of_people, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validate :start_end_check

  def start_end_check
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "は開始日以降の日付を選択してください") if end_date < start_date
  end
end
