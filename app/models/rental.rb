class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  enum status: { scheduled: 0, in_progress: 5 }
  validates :start_date, presence: { message: 'Data de início não pode ficar em branco' }
  validates :end_date, presence: { message: 'Data de fim não pode ficar em branco' }
  validate :end_date_must_be_greater_than_start_date,
           :start_date_equal_or_greater_than_today
  validate :cars_available, on: :create

  def end_date_must_be_greater_than_start_date
    return unless start_date.present? && end_date.present?

    if end_date <= start_date
      errors.add(:end_date, 'deve ser maior que data de início')
    end
  end

  def start_date_equal_or_greater_than_today
    return unless start_date.present?

    if start_date < Date.current
      errors.add(:start_date, 'deve ser maior que a data de hoje.')
    end
  end

  def cars_available
    return unless start_date.present? && end_date.present?

    if cars_available_at_date_range
      errors.add(:category, 'Não há carros disponíveis na categoria escolhida.')
    end
  end

  private

  def cars_available_at_date_range
    scheduled_rentals = Rental.where(car_category: car_category)
                              .where(start_date: start_date..end_date)
                              .or(Rental.where(car_category: car_category)
                              .where(end_date: start_date..end_date))

    available_cars = Car.joins(:car_model)
                        .where(car_models: { car_category: car_category })

    scheduled_rentals.count >= available_cars.count
  end
end
