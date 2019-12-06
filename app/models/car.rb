class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary

  validates :license_plate, :color, :mileage, presence: {message: 'O campo deve ser preenchido'}
  validates :license_plate, uniqueness: {message: 'Placa já cadastrada'}
  validates :mileage, numericality: {greater_than_or_equal_to: 0, message:'Valor deve ser maior ou igual a zero'} 
end
