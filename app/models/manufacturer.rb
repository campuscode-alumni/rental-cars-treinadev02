class Manufacturer < ApplicationRecord
  validates :name, presence: {message: 'O campo deve ser preenchido'}
  validates :name, uniqueness: { message: 'Nome já esta em uso'} 
end
