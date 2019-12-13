require 'rails_helper'

feature 'User edit client' do
    scenario 'successfully' do
        user = create(:user, role: :employee)
        login_as(user)
        
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
        user = create(:user, role: :employee)
        login_as(user)
        
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
        user = create(:user, role: :employee)
        login_as(user)
        
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

    scenario 'and using a invalid CPF' do
        user = create(:user, role: :employee)
        login_as(user)

        Client.create!(name: 'Fulano', cpf: '253.756.110-40', email: 'siclano@client.com')

        visit clients_path 
        click_on 'Fulano'
        click_on 'Editar'
        
        fill_in 'Nome', with: 'Fulano'
        fill_in 'CPF', with: '123.456.789-10'
        fill_in 'Email', with: 'fulano@client.com'


        click_on 'Enviar'

        expect(page).to have_content('CPF é invalido')
    end

    scenario 'and using a alfanumeric CPF' do
        user = create(:user, role: :employee)
        login_as(user)
        
        Client.create!(name: 'Fulano', cpf: '253.756.110-40', email: 'siclano@client.com')

        visit clients_path 
        click_on 'Fulano'
        click_on 'Editar'

        fill_in 'Nome', with: 'Fulano'
        fill_in 'CPF', with: '123.ABC.789-10'
        fill_in 'Email', with: 'fulano@client.com'


        click_on 'Enviar'

        expect(page).to have_content('CPF não deve conter letras, apenas numeros')
    end

    scenario 'and using a CPF with less number than necessary' do
        user = create(:user, role: :employee)
        login_as(user)
        
        Client.create!(name: 'Fulano', cpf: '253.756.110-40', email: 'siclano@client.com')

        visit clients_path 
        click_on 'Fulano'
        click_on 'Editar'

        fill_in 'Nome', with: 'Fulano'
        fill_in 'CPF', with: '123'
        fill_in 'Email', with: 'fulano@client.com'


        click_on 'Enviar'

        expect(page).to have_content('Tamanho do CPF invalido, ele deve ter 11 algarismos')
    end

    scenario 'and try update a client without sing in' do
        client = Client.create!(name: 'Siclano', cpf: '111.111.111-11', email: 'siclano@client.com')
        
        visit edit_client_path(client)
        
        expect(current_path).to eq(new_user_session_path)
    end

    scenario 'successfully' do
        user = create(:user)
        login_as(user)
        
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

end