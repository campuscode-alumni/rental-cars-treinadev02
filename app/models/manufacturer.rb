class Manufacturer < ApplicationRecord
  validates :name, presence: {message: 'Todos os campos devem ser preenchidos'}
  validates :name, uniqueness: { message: 'Nome já esta em uso'} 
end
