require 'rails_helper'

feature 'Admin edit subsidiary' do
    scenario 'successfully' do 
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)
        
        Subsidiary.create!(name: 'Filial SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')

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
        expect(page). to have_content('Filial alterada com sucesso')
    end 

    scenario 'and must fill in all fiedls' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)
        
        Subsidiary.create!(name: 'Filial SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')

        visit subsidiaries_path
        click_on 'Filial SP'
        click_on 'Editar'

        fill_in 'Nome', with: ''
        click_on 'Enviar'

        expect(page).to have_content('O campo deve ser preenchido')
    end

    scenario 'and must be unique' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)
        
        Subsidiary.create!(name: 'Filial SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')
        Subsidiary.create!(name: 'Filial MG', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')

        visit subsidiaries_path
        click_on 'Filial SP'
        click_on 'Editar'

        fill_in 'Nome', with: 'Filial MG'
        click_on 'Enviar'

        expect(page).to have_content('Nome já esta em uso')
    end

    scenario 'access update without a admin user' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789')
        login_as(user)
    
        subsidiary = Subsidiary.create!(name: 'Filial SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')
        
        visit edit_subsidiary_path(subsidiary) 
    
        expect(current_path).to eq(root_path)
      end

end
