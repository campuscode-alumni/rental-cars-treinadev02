require 'rails_helper'

feature 'user register a rental' do
    scenario 'successfully using an user account' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789')
        login_as(user)
        
        Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')

        CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                            car_insurance: '35', third_party_insurance: '29')
        
        visit root_path
        click_on 'Agendamento de locação de carro'
        click_on 'Agendar locação'

        fill_in 'Data Inicial', with: '2019/01/01'
        fill_in 'Data Final', with: '2019/01/07'
        select 'Fulano', from: 'Cliente'
        select 'Carro pequeno', from: 'Categoria'

        click_on 'Enviar'

        expect(page).to have_content('Locação agendada com sucesso')
        
        expect(page).to have_content('2019-01-01')
        expect(page).to have_content('2019-01-07')
        expect(page).to have_content('Fulano')
        expect(page).to have_content('Carro pequeno')
    end

    scenario 'successfully using an admin account' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)
        
        Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')

        CarCategory.create!(name: 'Carro pequeno', daily_rate: '90', 
                            car_insurance: '35', third_party_insurance: '29')
        
        visit root_path
        click_on 'Agendamento de locação de carro'
        click_on 'Agendar locação'

        fill_in 'Data Inicial', with: '2019/01/01'
        fill_in 'Data Final', with: '2019/01/07'
        select 'Fulano', from: 'Cliente'
        select 'Carro pequeno', from: 'Categoria'

        click_on 'Enviar'

        expect(page).to have_content('Locação agendada com sucesso')
        
        expect(page).to have_content('2019-01-01')
        expect(page).to have_content('2019-01-07')
        expect(page).to have_content('Fulano')
        expect(page).to have_content('Carro pequeno')
    end

    scenario 'and try create a rental without sing in' do
        visit new_rental_path
        
        expect(current_path).to eq(new_user_session_path)
    end

    scenario 'and cant see a rental option without sing in' do
        visit root_path
        
        expect(page).not_to have_content('Agendamento de locação de carro')
    end
end
    