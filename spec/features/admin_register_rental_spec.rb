require 'rails_helper'

feature 'Admin creat a rental' do
    scenario 'successfully' do
        user = create(:user)
        login_as(user)

        client = Client.create!(name: 'Fulano', cpf: '932.054.760-26', email: 'fulano@client.com')

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
        expect(page).to have_content('Fulano - 932.054.760-26')
        expect(page).to have_content('Carro pequeno')
    end
end