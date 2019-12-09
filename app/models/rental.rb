class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  validates :start_date, :end_date, presence: true
  validate :end_date_must_be_greater_than_start_date

  def end_date_must_be_greater_than_start_date
    # return unless start_date.present? || end_date.present?

    if end_date < start_date
      errors.add(:end_date, 'deve ser maior que data de início')
    end
  end
end
