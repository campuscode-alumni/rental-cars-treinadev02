require 'rails_helper'

describe Rental, type: :model do
  describe '.end_date_must_be_greater_than_star_date' do
    
    it 'success' do
      client = Client.create!(name: 'Fulano', cpf: '116.106.750-70',email: 'fulano@client.com')

      car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90',car_insurance: '35', third_party_insurance: '29')

      rental = Rental.new(start_date: Date.tomorrow , end_date:Date.tomorrow.next_day(3) ,client_id: client.id, car_category_id: car_category.id )

      rental.valid?

      expect(rental.errors).to be_empty
    end

    it 'and date greater than start date' do
      client = Client.create!(name: 'Fulano', cpf: '116.106.750-70',
        email: 'fulano@client.com')

      car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                   car_insurance: '35', third_party_insurance: '29')

      rental = Rental.new(start_date: Date.today.prev_day(3), end_date: Date.tomorrow, 
                          client_id: client.id, car_category_id: car_category.id )
      
      expect(rental).not_to be_valid
      expect(rental.errors.full_messages).to include('Start date deve ser maior ou igual a data atual')
    end

    it 'and date less than start date' do
      client = Client.create!(name: 'Fulano', cpf: '116.106.750-70',
        email: 'fulano@client.com')

      car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                   car_insurance: '35', third_party_insurance: '29')

      rental = Rental.new(start_date: Date.tomorrow , end_date: Date.yesterday, 
                          client_id: client.id, car_category_id: car_category.id )

      rental.valid?

      expect(rental.errors.full_messages).to include('End date deve ser maior que a data de inicio')
    end

    it 'end date equal than start date' do
      client = Client.create!(name: 'Fulano', cpf: '116.106.750-70',
        email: 'fulano@client.com')

      car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                   car_insurance: '35', third_party_insurance: '29')

      rental = Rental.new(start_date: Date.today , end_date: Date.today, 
                          client_id: client.id, car_category_id: car_category.id )

      expect(rental).to be_valid
    end

    it 'star date must exist' do
      client = Client.create!(name: 'Fulano', cpf: '116.106.750-70',
        email: 'fulano@client.com')

      car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                   car_insurance: '35', third_party_insurance: '29')

      rental = Rental.new(end_date: Date.yesterday, 
                          client_id: client.id, car_category_id: car_category.id )
      
      expect(rental).not_to be_valid
      expect(rental.errors.full_messages).to include('Start date O campo deve ser preenchido')
    end

    it 'end date must exist' do
      client = Client.create!(name: 'Fulano', cpf: '116.106.750-70',
        email: 'fulano@client.com')

      car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                   car_insurance: '35', third_party_insurance: '29')

      rental = Rental.new(start_date: Date.today, 
                          client_id: client.id, car_category_id: car_category.id )
      
      expect(rental).not_to be_valid
      expect(rental.errors.full_messages).to include('End date O campo deve ser preenchido')
    end
  end

  describe '.car_avalible?' do 

    it 'should be false if subsidiary has no cars' do
      client = Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')

        Client.create!(name: 'Siclano', cpf: '111.111.111-11', email: 'siclano@client.com')

        car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                                       car_insurance: '35', third_party_insurance: '29')

        CarCategory.create!(name: 'Carro grande', daily_rate: '120', 
                            car_insurance: '35', third_party_insurance: '29')
        
        subsidiary = Subsidiary.create!(name: 'Unidade SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')
        
        rental = Rental.create!(start_date: '2019-12-01', end_date: '2019-12-07', 
                       client_id:client.id, car_category_id:car_category.id, reservation_code: 123456, subsidiary_id:subsidiary.id)

                       

      result = rental.car_avalible?
      expect(result).to be false
    end

    it 'should be false if subsidiary has no cars' do
      client = Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')

        Client.create!(name: 'Siclano', cpf: '111.111.111-11', email: 'siclano@client.com')

        car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                                       car_insurance: '35', third_party_insurance: '29')

        CarCategory.create!(name: 'Carro grande', daily_rate: '120', 
                            car_insurance: '35', third_party_insurance: '29')
        
        subsidiary = Subsidiary.create!(name: 'Unidade SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')

        manufacturer = Manufacturer.create!(name: 'Chevrolet')

        car_model = CarModel.create!(name: 'Cruzer', year: '2018', fuel_type: 'Gásolina',motorization: '1.8',
            manufacturer_id: manufacturer.id, car_category_id: car_category.id)

        Car.create!(license_plate: 'AAA-1111', color: 'Azul', mileage: '0', 
                    subsidiary_id:subsidiary.id, car_model_id: car_model.id)
        
        rental = Rental.create!(start_date: '2019-12-01', end_date: '2019-12-07', 
                       client_id:client.id, car_category_id:car_category.id, reservation_code: 123456, subsidiary_id:subsidiary.id)

                       

      result = rental.car_avalible?
      expect(result).to be true
    end

    it 'should be false if subsidiary has no car from rental category' do
        client = Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')

        car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                                       car_insurance: '35', third_party_insurance: '29')

        outher_category = CarCategory.create!(name: 'Carro grande', daily_rate: '120', 
                            car_insurance: '35', third_party_insurance: '29')
        
        subsidiary = Subsidiary.create!(name: 'Unidade SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')

        manufacturer = Manufacturer.create!(name: 'Chevrolet')

        car_model = CarModel.create!(name: 'Cruzer', year: '2018', fuel_type: 'Gásolina',motorization: '1.8',
            manufacturer_id: manufacturer.id, car_category_id: car_category.id)

        Car.create!(license_plate: 'AAA-1111', color: 'Azul', mileage: '0', 
                    subsidiary_id:subsidiary.id, car_model_id: car_model.id)
        
        rental = Rental.create!(start_date: '2019-12-01', end_date: '2019-12-07', 
                       client_id:client.id, car_category_id:outher_category.id, reservation_code: 123456, subsidiary_id:subsidiary.id)

                       

      result = rental.car_avalible?
      expect(result).to be false
    end

    it 'should be false is subsidiary has rentals scheduled' do
      client = Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')

        Client.create!(name: 'Siclano', cpf: '111.111.111-11', email: 'siclano@client.com')

        car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                                       car_insurance: '35', third_party_insurance: '29')

        CarCategory.create!(name: 'Carro grande', daily_rate: '120', 
                            car_insurance: '35', third_party_insurance: '29')
        
        subsidiary = Subsidiary.create!(name: 'Unidade SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')

        manufacturer = Manufacturer.create!(name: 'Chevrolet')

        car_model = CarModel.create!(name: 'Cruzer', year: '2018', fuel_type: 'Gásolina',motorization: '1.8',
            manufacturer_id: manufacturer.id, car_category_id: car_category.id)

        Car.create!(license_plate: 'AAA-1111', color: 'Azul', mileage: '0', 
                    subsidiary_id:subsidiary.id, car_model_id: car_model.id)
        
        rental = Rental.create!(start_date: 1.day.from_now, end_date: 5.days.from_now, 
                       client_id:client.id, car_category_id:car_category.id, reservation_code: 123456, subsidiary_id:subsidiary.id, status: :scheduled)

        outher_rental = Rental.create!(start_date: 2.days.from_now, end_date: 3.day.from_now, 
        client_id:client.id, car_category_id:car_category.id, reservation_code: 123456, subsidiary_id:subsidiary.id)
        
      result = outher_rental.car_avalible?
      expect(result).to be false
    end

  end



end