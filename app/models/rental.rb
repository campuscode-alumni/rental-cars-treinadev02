class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category

  validate :end_date_must_be_greater_than_star_date

  def end_date_must_be_greater_than_star_date
    if end_date < start_date
      errors.add(:end_date, 'deve ser maior que a data de inicio')  
    end
  end

end
