require 'rails_helper'

feature 'User edit client' do
    scenario 'successfully' do
        
        
        Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')

        visit root_path
        click_on 'Clientes'
        click_on 'Fulano'
        click_on 'Editar'

        fill_in 'Nome', with: 'Siclano'
        fill_in 'CPF', with: '111.111.111-11'
        fill_in 'Email', with: 'siclano@client.com'
        click_on 'Enviar'

        expect(page).to have_content('Siclano')
        expect(page).to have_content('111.111.111-11')
        expect(page).to have_content('siclano@client.com')

        expect(page).to have_content('Cliente atualizado com sucesso')
    end

    scenario 'and must fill all fields' do
        Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')

        visit clients_path
        click_on 'Fulano'
        click_on 'Editar'

        fill_in 'Nome', with: ''
        fill_in 'CPF', with: ''
        fill_in 'Email', with: ''

        click_on 'Enviar'

        expect(page).to have_content('O campo deve ser preenchido')
    end

    scenario 'and must be unique' do
        Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')
        Client.create!(name: 'Siclano', cpf: '111.111.111-11', email: 'siclano@client.com')

        visit clients_path 
        click_on 'Fulano'
        click_on 'Editar'

        fill_in 'Nome', with: 'Siclano'
        fill_in 'CPF', with: '111.111.111-11'
        fill_in 'Email', with: 'siclano@client.com'

        click_on 'Enviar'

        expect(page).to have_content('O valor já esta em uso')
    end
end