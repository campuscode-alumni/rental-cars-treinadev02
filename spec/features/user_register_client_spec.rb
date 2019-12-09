require 'rails_helper'

feature 'Admin register a cliente' do
    scenario 'successfully' do
        user = create(:user, role: :employee)
        login_as(user)
        
        visit root_path
        click_on 'Clientes'
        click_on 'Cadastra clientes'

        fill_in 'Nome', with: 'Rodrigo'
        fill_in 'CPF', with: '347.349.950-10'
        fill_in 'Email', with: 'rodrigo@google.com'

        click_on 'Enviar'

        expect(page).to have_content('Cliente cadastrado com sucesso')    
        
        expect(page).to have_content('Rodrigo')
        expect(page).to have_content('347.349.950-10')
        expect(page).to have_content('rodrigo@google.com')
    end

    scenario 'and must fill all fields' do
        user = create(:user, role: :employee)
        login_as(user)
        
        visit new_client_path

        click_on 'Enviar'

        expect(page).to have_content('O campo deve ser preenchido')
    end

    scenario 'and must be unique' do
        user = create(:user, role: :employee)
        login_as(user)
       
        Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')
        
        visit new_client_path 
        
        fill_in 'Nome', with: 'Fulano'
        fill_in 'CPF', with: '000.000.000-00'
        fill_in 'Email', with: 'fulano@client.com'

        click_on 'Enviar'

        expect(page).to have_content('O valor já esta em uso')
    end

    scenario 'and using a invalid CPF' do
        user = create(:user, role: :employee)
        login_as(user)
        
        visit new_client_path
        fill_in 'Nome', with: 'Fulano'
        fill_in 'CPF', with: '123.456.789-10'
        fill_in 'Email', with: 'fulano@client.com'


        click_on 'Enviar'

        expect(page).to have_content('CPF é invalido')
    end

    scenario 'and using a alfanumeric CPF' do
        user = create(:user, role: :employee)
        login_as(user)
        
        visit new_client_path
        fill_in 'Nome', with: 'Fulano'
        fill_in 'CPF', with: '123.ABC.789-10'
        fill_in 'Email', with: 'fulano@client.com'


        click_on 'Enviar'

        expect(page).to have_content('CPF não deve conter letras, apenas numeros')
    end

    scenario 'and using a CPF with less number than necessary' do
        user = create(:user, role: :employee)
        login_as(user)
        
        visit new_client_path
        fill_in 'Nome', with: 'Fulano'
        fill_in 'CPF', with: '123'
        fill_in 'Email', with: 'fulano@client.com'


        click_on 'Enviar'

        expect(page).to have_content('Tamanho do CPF invalido, ele deve ter 11 algarismos')
    end

    scenario 'and try create a client without sing in' do
        visit new_client_path
        
        expect(current_path).to eq(new_user_session_path)
    end

    scenario 'and cant see a client option without sing in' do
        visit root_path
        
        expect(page).not_to have_content('Clientes')
    end
end