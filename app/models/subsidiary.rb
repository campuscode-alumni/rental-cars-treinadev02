class Subsidiary < ApplicationRecord
    validates :name, :cnpj, :address, presence: {message: 'O campo deve ser preenchido'}
    validates :name, uniqueness: {message: 'Nome já esta em uso'}

    has_many :user
    has_many :car
end
