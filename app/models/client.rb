class Client < ApplicationRecord
    validates :name, :cpf, :email, presence: {message: 'O campo deve ser preenchido'}
    validates :name, :cpf, :email, uniqueness: {message: 'O valor já esta em uso'}

end
