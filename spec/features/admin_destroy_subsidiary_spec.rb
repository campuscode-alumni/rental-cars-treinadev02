require 'rails_helper'

feature 'Admin delete a subsidiary' do
    scenario 'successfully' do
        Subsidiary.create!(name: 'Filial SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')
                           
        visit subsidiaries_path
        click_on 'Filial SP'
        click_on 'Remover'

        expect(page).to_not have_content('Filial SP')
        expect(page).to have_content('Filial removida com sucesso')
    end
end