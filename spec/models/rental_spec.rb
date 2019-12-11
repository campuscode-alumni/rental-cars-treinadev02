require 'rails_helper'

RSpec.describe Rental, type: :model do
  describe '.end_date_must_be_greater_than_start_date' do
    it 'success' do
      subsidiary = Subsidiary.create!(name: 'Almeidinha Cars',
                                      cnpj: '00.000.000/0000-00',
                                      address: 'Alameda Santos, 1293')
      client = Client.new(name: 'Fulano Sicrano', email: 'fulano@test.com',
                          document: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30,
                                 car_insurance: 30,
                                 third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_model = CarModel.create!(name: 'Onix', year: 2000,
                                   manufacturer: manufacturer, fuel_type: 'Flex',
                                   motorization: '1.0',
                                   car_category: category)
      Car.create!(car_model: car_model, license_plate: 'ABC1234',
                  color: 'Verde', mileage: 0, subsidiary: subsidiary)
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.from_now,
                          client: client, car_category: category)

      rental.valid?

      expect(rental.errors).to be_empty
    end

    it 'end date less than start date' do
      rental = Rental.new(start_date: '09/12/2019', end_date: '08/12/2019')

      rental.valid?

      expect(rental.errors.full_messages).to include(
        'End date deve ser maior que data de início'
      )
    end

    it 'end date equal than start date' do
      rental = Rental.new(start_date: '09/12/2019', end_date: '09/12/2019')

      rental.valid?

      expect(rental.errors.full_messages).to include(
        'End date deve ser maior que data de início'
      )
    end

    it 'start date must exist' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulano@test.com',
                          document: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30,
                                 car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: nil, end_date: '10/12/2019',
                          client: client, car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include(
        'Start date Data de início não pode ficar em branco'
      )
    end

    it 'start date must exist' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulano@test.com',
                          document: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30,
                                 car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '', end_date: '10/12/2019',
                          client: client, car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include(
        'Start date Data de início não pode ficar em branco'
      )
    end

    it 'end date must exist' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulano@test.com',
                          document: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30,
                                 car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '10/12/2019', end_date: nil,
                          client: client, car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include(
        'End date Data de fim não pode ficar em branco'
      )
    end

    it 'start date must exist' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulano@test.com',
                          document: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30,
                                 car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '10/12/2019', end_date: '',
                          client: client, car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include(
        'End date Data de fim não pode ficar em branco'
      )
    end
  end
end
