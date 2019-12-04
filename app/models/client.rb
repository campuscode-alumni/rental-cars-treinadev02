class Client < ApplicationRecord
  validates :name, presence: { message: 'Não pode ficar em branco'}
  validates :cpf, presence: { message: 'Não pode ficar em branco'}
  validates :email, presence: { message: 'Não pode ficar em branco'}
  validates :name, uniqueness: { message: 'Nome já está em uso'}
  validates :cpf, uniqueness: { message: 'CPF já está em uso'}
  validates :email, uniqueness: { message: 'Email já está em uso'}
end
