require 'rails_helper'

feature 'user register a rental' do
    scenario 'successfully' do
        client = Client.new(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')
        client.save! 

        Client.create!(name: 'Siclano', cpf: '111.111.111-11', email: 'siclano@client.com')

        car_category = CarCategory.new(name: 'Carro pequeno', daily_rate: '90', 
                                       car_insurance: '35', third_party_insurance: '29')
        car_category.save!

        CarCategory.create!(name: 'Carro grande', daily_rate: '120', 
                            car_insurance: '35', third_party_insurance: '29')
        
        Rental.create!(start_date: '2019-12-01', end_date: '2019-12-07', 
                       client_id:client.id, car_category_id:car_category.id)

        visit root_path
        click_on 'Agendamento de locação de carro'
        click_on 'Fulano'
        click_on 'Editar'

        fill_in 'Data Inicial', with: '2019/01/01'
        fill_in 'Data Final', with: '2019/01/07'
        select 'Siclano', from: 'Cliente'
        select 'Carro grande', from: 'Categoria'

        click_on 'Enviar'

        expect(page).to have_content('Locação alterada com sucesso')
        
        expect(page).to have_content('2019-01-01')
        expect(page).to have_content('2019-01-07')
        expect(page).to have_content('Siclano')
        expect(page).to have_content('Carro grande')
    end
end
    
       