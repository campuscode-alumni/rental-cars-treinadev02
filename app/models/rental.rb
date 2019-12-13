class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :subsidiary

  has_one :car_rental
  has_one :car, through: :car_rental

  validates :start_date, :end_date, presence: {message: 'O campo deve ser preenchido'}
  validate :end_date_must_be_greater_than_star_date
  validate :start_date_must_be_greater_than_or_equal_today

  enum status: {scheduled: 0 , in_progress: 1}

  def show_status
    if scheduled?
      "Agendado"
    else
      "Em progresso"
    end
  end

  def end_date_must_be_greater_than_star_date
      return unless start_date.presence || end_date.presence
      
      if end_date < start_date
        errors.add(:end_date, 'deve ser maior que a data de inicio')  
      end
  end

  def start_date_must_be_greater_than_or_equal_today
    return unless !start_date.presence || !end_date.presence
      if start_date >= Date.current
          errors.add(:start_date, 'deve ser maior ou igual a data atual')  
      end
  end

  def car_avalible?
    car_models = CarModel.where(car_category: car_category)
    total_cars = Car.where(car_model: car_models).count > 0

    total_rentals = Rental.where(car_category: car_category, subsidiary: subsidiary)
                         .where("start_date < ? and end_date > ?", start_date, start_date)
                         .count

    (total_cars - total_rentals) > 0

    
  end

  #def calculate_reservation_code
    #self.reservation_code = ((start_date.ld + end_date.ld + Time.now.usec)  / 100)
  #end
end
