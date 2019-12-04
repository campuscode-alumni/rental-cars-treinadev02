require 'rails_helper'

feature 'Admin register a cliente' do
    scenario 'successfully' do
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
        visit new_client_path

        click_on 'Enviar'

        expect(page).to have_content('O campo deve ser preenchido')
    end

    scenario 'and must be unique' do
        Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com')
        
        visit new_client_path 
        
        fill_in 'Nome', with: 'Fulano'
        fill_in 'CPF', with: '000.000.000-00'
        fill_in 'Email', with: 'fulano@client.com'

        click_on 'Enviar'

        expect(page).to have_content('O valor já esta em uso')
    end
end