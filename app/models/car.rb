class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  has_one :car_category, through: :car_model
  enum status: { available: 0, unavailable: 5 }
  has_many :car_rentals
  has_many :rentals, through: :car_rentals

  def name
    "#{car_model.name} - #{license_plate}"
  end

  def price
    car_category.daily_rate +
    car_category.third_party_insurance +
    car_category.car_insurance
  end
end
