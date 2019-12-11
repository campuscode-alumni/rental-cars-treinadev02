require 'rails_helper'

feature 'user register a rental' do
    scenario 'successfully using an user account' do
        user = create(:user, role: :employee)
        login_as(user)
        
        client = Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')

        Client.create!(name: 'Siclano', cpf: '111.111.111-11', email: 'siclano@client.com')

        car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                                       car_insurance: '35', third_party_insurance: '29')

        CarCategory.create!(name: 'Carro grande', daily_rate: '120', 
                            car_insurance: '35', third_party_insurance: '29')
        
        rental = Rental.create!(start_date: '2019-12-01', end_date: '2019-12-07', 
                       client_id:client.id, car_category_id:car_category.id, reservation_code: 123456)

        visit root_path
        click_on 'Locação'
        click_on '123456'
        click_on 'Editar'

        fill_in 'Data Inicial', with: '2019/01/01'
        fill_in 'Data Final', with: '2019/01/07'
        select "#{client.name} - #{client.cpf}" , from: 'Cliente'
        select car_category.name , from: 'Categoria'

        click_on 'Enviar'

        expect(page).to have_content('Locação alterada com sucesso')
        
        expect(page).to have_content('01/01/2019')
        expect(page).to have_content('07/01/2019')
        expect(page).to have_content("#{client.name} - #{client.cpf}")
        expect(page).to have_content(car_category.name)
    end

    scenario 'successfully using an admin account' do
        user = create(:user, role: :admin)
        login_as(user)
        
        client = Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')

        Client.create!(name: 'Siclano', cpf: '111.111.111-11', email: 'siclano@client.com')

        car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                                       car_insurance: '35', third_party_insurance: '29')

        CarCategory.create!(name: 'Carro grande', daily_rate: '120', 
                            car_insurance: '35', third_party_insurance: '29')
        
        Rental.create!(start_date: '2019-12-01', end_date: '2019-12-07', 
                       client_id:client.id, car_category_id:car_category.id, reservation_code: '123456')

        visit root_path
        click_on 'Locação'
        click_on '123456'
        click_on 'Editar'

        fill_in 'Data Inicial', with: '2019/01/01'
        fill_in 'Data Final', with: '2019/01/07'
        select "#{client.name} - #{client.cpf}" , from: 'Cliente'
        select car_category.name , from: 'Categoria'

        click_on 'Enviar'

        expect(page).to have_content('Locação alterada com sucesso')
        
        expect(page).to have_content('01/01/2019')
        expect(page).to have_content('07/01/2019')
        expect(page).to have_content("#{client.name} - #{client.cpf}")
        expect(page).to have_content(car_category.name)
    end

    scenario 'and try update a rental without sing in' do
        client = Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')

        Client.create!(name: 'Siclano', cpf: '111.111.111-11', email: 'siclano@client.com')

        car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                                       car_insurance: '35', third_party_insurance: '29')

        CarCategory.create!(name: 'Carro grande', daily_rate: '120', 
                            car_insurance: '35', third_party_insurance: '29')
        
        rental = Rental.create!(start_date: '2019-12-01', end_date: '2019-12-07', 
                       client_id:client.id, car_category_id:car_category.id, reservation_code: '123456')
        
        visit edit_rental_path(rental)
        
        expect(current_path).to eq(new_user_session_path)
    end

    scenario 'and cant see a rental option without sing in' do
        visit root_path
        
        expect(page).not_to have_content('Agendamento de locação de carro')
    end
end
    
       