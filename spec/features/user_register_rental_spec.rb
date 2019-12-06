require 'rails_helper'

feature 'user register a rental' do
    scenario 'successfully' do
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
end
    