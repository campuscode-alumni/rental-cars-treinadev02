class Client < ApplicationRecord
  validates :email, presence: { message: 'não pode ficar em branco' }
  validates :name, presence: { message: 'Nome não pode ficar em branco' }
  validates :document, presence: { message: 'CPF não pode ficar em branco' }
end
