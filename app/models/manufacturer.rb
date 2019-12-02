class Manufacturer < ApplicationRecord
  validates :name, presence: { message: 'Não pode ficar em branco'}
  validates :name, uniqueness: { message: 'Nome já está em uso'}
end
