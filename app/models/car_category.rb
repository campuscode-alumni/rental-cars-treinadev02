class CarCategory < ApplicationRecord
    has_many :car_models
    has_many :rental
    has_many :cars, through: :car_models
    
    validates :name, presence: {message: 'O campo deve ser preenchido'}
    validates :daily_rate, :car_insurance, :third_party_insurance, numericality: {greater_than: 0, message: 'Valor deve ser maior que zero'}
    validates :name, uniqueness: {message: 'O nome deve ser unico'}

    def price 
        daily_rate + car_insurance + third_party_insurance
    end
end
