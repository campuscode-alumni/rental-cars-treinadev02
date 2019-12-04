class Manufacturer < ApplicationRecord
  validates :name, presence: { message: 'não pode ficar em branco' }
  validates :name, uniqueness: { message: 'Nome já está em uso' }
  has_many :car_models
end
