class Subsidiary < ApplicationRecord
  validates :name, presence: { message: 'Não pode ficar em branco'}
  validates :cnpj, presence: { message: 'Não pode ficar em branco'}
  validates :address, presence: { message: 'Não pode ficar em branco'}
  validates :name, uniqueness: { message: 'Nome já está em uso'}
  validates :cnpj, uniqueness: { message: 'CNPJ já está em uso'}
  validates :address, uniqueness: { message: 'Address já está em uso'}
end
