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
end