require 'rails_helper'

feature 'User register a rental' do
    scenario 'successfully' do
        user = create(:user, role: :employee)
        login_as(user)
        
        client = Client.create!(name: 'Fulano', cpf: '116.106.750-70', email: 'fulano@client.com')

        car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                            car_insurance: '35', third_party_insurance: '29')
        
        visit root_path
        click_on 'Locação'
        click_on 'Agendar locação'

        fill_in 'Data Inicial', with: '2019/01/01'
        fill_in 'Data Final', with: '2019/01/07'
        select "#{client.name} - #{client.cpf}" , from: 'Cliente'
        select car_category.name , from: 'Categoria'

        click_on 'Enviar'

        expect(page).to have_content('Locação agendada com sucesso')
        
        expect(page).to have_content('01/01/2019')
        expect(page).to have_content('07/01/2019')
        expect(page).to have_content("#{client.name} - #{client.cpf}")
        expect(page).to have_content(car_category.name)
    end

    scenario 'and try create a rental without sing in' do
        visit new_rental_path
        
        expect(current_path).to eq(new_user_session_path)
    end

    scenario 'and cant see a rental option without sing in' do
        visit root_path
        
        expect(page).not_to have_content('Agendamento de locação de carro')
    end

    
    scenario 'must fill all fields' do
        user = create(:user, role: :employee)
        login_as(user)
        
        visit new_rental_path

        click_on 'Enviar'

        expect(page).to have_content('O campo deve ser preenchido')
    end

    scenario 'and start date must be less or equal to end date' do
        user = create(:user, role: :employee)
        login_as(user)
        
        client = create(:client)

        car_category = create(:car_category)
        
        visit new_rental_path

        fill_in 'Data Inicial', with: '2019/01/07'
        fill_in 'Data Final', with: '2019/01/01'
        select "#{client.name} - #{client.cpf}" , from: 'Cliente'
        select car_category.name , from: 'Categoria'

        click_on 'Enviar'

        expect(page).to have_content('deve ser maior que a data de inicio')
    end

    scenario 'and start date must be bigger or equal to today' do
        user = create(:user, role: :employee)
        login_as(user)
        
        client = create(:client)

        car_category = create(:car_category)
        
        visit new_rental_path

        fill_in 'Data Inicial', with: DateTime.now.prev_day
        fill_in 'Data Final', with: DateTime.now.next_day
        select "#{client.name} - #{client.cpf}" , from: 'Cliente'
        select car_category.name , from: 'Categoria'

        click_on 'Enviar'

        expect(page).to have_content('Data de inicio deve ser maior ou igual a data atual')
    end


end
    