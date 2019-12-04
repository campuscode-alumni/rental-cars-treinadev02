class Subsidiary < ApplicationRecord
  validates :name, presence: { message: 'Nome não pode ficar em branco' }
  validates :cnpj, presence: { message: 'CNPJ não pode ficar em branco' }
  validates :address, presence: { message: 'Endereço não pode ficar em branco' }
end
