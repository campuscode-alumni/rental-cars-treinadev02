class CarRental < ApplicationRecord
  belongs_to :car
  belongs_to :rental
end
