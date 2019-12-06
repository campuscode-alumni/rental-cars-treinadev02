class CarModel < ApplicationRecord
  belongs_to :car_category
  belongs_to :manufacturer

  validates :name, :motorization, :fuel_type, presence: {message: 'O campo deve ser preenchido'}
  validates :name, uniqueness: {message: 'O modelo já existe'}
  validates :year, numericality: {greater_than: 1980, message: 'Ano deve ser maior que 1980'}
end
