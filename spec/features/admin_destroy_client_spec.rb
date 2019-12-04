require 'rails_helper'

feature 'Admin delete a client' do
    scenario 'successfully' do
        Client.create!(name: 'Fulano', cpf: '000.000.000-00', email: 'fulano@client.com') 
                           
        visit clients_path
        click_on 'Fulano'
        click_on 'Remover'

        expect(page).to_not have_content('Fulano')
        expect(page).to have_content('Cliente removido com sucesso')
    end
end