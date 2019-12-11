require 'rails_helper'

feature 'Admin register a user' do
    scenario 'successfully' do
        user = create(:user)
        login_as(user)

        subsidiary = create(:subsidiary)

        visit root_path
        click_on 'Usuários'
        click_on 'Cadastra usuário'

        select subsidiary.name, from: 'Filial'
        fill_in 'Email', with: 'usuario@teste.com.br'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirmação de senha', with: '123456'

        click_on 'Enviar'

        expect(page).to have_content('usuario@teste.com.br')
        expect(page).to have_content(subsidiary.name)
    end
end