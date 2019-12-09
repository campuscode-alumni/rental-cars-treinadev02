require 'rails_helper'

feature 'Admin register a cliente' do 
    scenario 'successfully' do
        user = create(:user)
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
end