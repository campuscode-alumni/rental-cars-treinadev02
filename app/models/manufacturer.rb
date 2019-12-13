class Manufacturer < ApplicationRecord
  has_many :car_models
  
  validates :name, presence: {message: 'O campo deve ser preenchido'}
  validates :name, uniqueness: { message: 'Nome já esta em uso'} 

end
