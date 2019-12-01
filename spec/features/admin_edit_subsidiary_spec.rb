require 'rails_helper'

feature 'Admin edit subsidiary' do
    scenario 'successfully' do 
        Subsidiary.create(name: 'Filial SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')

        visit root_path
        click_on 'Filiais'
        click_on 'Filial SP'
        click_on 'Editar'
        
        fill_in 'Nome', with: 'Filial unidade pompeia'
        fill_in 'CNPJ', with: '83.753.999/0001-77'
        fill_in 'Endereço', with: 'Av. Pompeia, 500'
        click_on 'Enviar'

        expect(page). to have_content('Filial unidade pompeia')
        expect(page). to have_content('83.753.999/0001-77')
        expect(page). to have_content('Av. Pompeia, 500')
    end 
end
