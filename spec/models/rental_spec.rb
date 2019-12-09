require 'rails_helper'

describe Rental, type: :model do
  describe '.end_date_must_be_greater_than_star_date' do
    it 'success' do
      client = Client.create!(name: 'Fulano', cpf: '116.106.750-70',email: 'fulano@client.com')

      car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90',car_insurance: '35', third_party_insurance: '29')

      rental = Rental.new(start_date: Date.today , end_date:Date.tomorrow,client_id: client.id, car_category_id: car_category.id )

      rental.valid?

      expect(rental.errors).to be_empty
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

    xit 'end date equal than start date' do
      
    end

    xit 'star date must exist' do

      #testar com data vazia e com ''
      expect(rental.errors.full_messages).to eq (['mensagem'])
    end

    xit 'end date must exist' do
      
    end
  end
end