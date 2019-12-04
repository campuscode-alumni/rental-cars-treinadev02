require 'rails_helper'

feature 'Visitor view client' do
    scenario 'successfully' do
        Client.create!(name: 'Fulano', cpf:'000.000.000-00', email: 'client@client.com')

        visit root_path
        click_on 'Clientes'
        click_on 'Fulano'

        expect(page).to have_content('Fulano')
        expect(page).to have_content('000.000.000-00')
        expect(page).to have_content('client@client.com')   
    end

    scenario 'and retrun to home page' do
        Client.create!(name: 'Fulano', cpf:'000.000.000-00', email: 'client@client.com')

        visit root_path
        click_on 'Clientes'
        click_on 'Fulano'
        click_on 'Voltar'

        expect(current_path).to eq root_path    
    end

    scenario 'and no-register of client' do
        visit clients_path

        expect(page).to have_content('Não possui clientes cadastrados.')
    end
end