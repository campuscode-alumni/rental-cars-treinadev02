require 'rails_helper'

feature 'Admin delete a subsidiary' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)

        Subsidiary.create!(name: 'Filial SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')
                           
        visit subsidiaries_path
        click_on 'Filial SP'
        click_on 'Remover'

        expect(page).to_not have_content('Filial SP')
        expect(page).to have_content('Filial removida com sucesso')
    end

    scenario 'and try to delete without login' do
        subsidiary = Subsidiary.create!(name: 'Filial SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')
                           
        visit subsidiary_path(subsidiary)

        expect(current_path).to eq(new_user_session_path) 
    end

end