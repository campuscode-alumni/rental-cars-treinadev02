class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :car, optional: true

  validates :start_date, :end_date, presence: {message: 'O campo deve ser preenchido'}
  validate :end_date_must_be_greater_than_star_date
  validate :start_date_must_be_greater_than_or_equal_today

  enum status: [:scheduled, :in_progress]

  def show_status
    if scheduled?
      "Agendado"
    else
      "Em progresso"
    end
  end

  def end_date_must_be_greater_than_star_date
      
      if !start_date.presence || !end_date.presence
        errors.add(:base, "As datas devem ser preenchidas")
      else
        if end_date < start_date
          errors.add(:end_date, 'deve ser maior que a data de inicio')  
        end
      end
  end

  def start_date_must_be_greater_than_or_equal_today
    if !start_date.presence || !end_date.presence
      return
    else
      time = Time.now.to_date
      unless start_date >= time
          errors.add(:start_date, 'deve ser maior ou igual a data atual')  
      end
    end
  end

  #def calculate_reservation_code
    #self.reservation_code = ((start_date.ld + end_date.ld + Time.now.usec)  / 100)
  #end
end
