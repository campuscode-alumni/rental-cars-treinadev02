require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    user = create(:user)
    login_as(user)
    
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Rental Card Filial'
    fill_in 'CNPJ', with: '43.466.839/0001-22'
    fill_in 'Endereço', with: 'Av. Paulista, 1527'
    click_on 'Enviar'

    expect(page).to have_content('Rental Card Filial')
    expect(page).to have_content('43.466.839/0001-22')
    expect(page).to have_content('Av. Paulista, 1527')
    expect(page).to have_content('Filial criada com sucesso')
  end

  scenario 'and must fill in all fiedls' do
    user = create(:user)
    login_as(user)
    
    visit new_subsidiary_path
    
    click_on 'Enviar'

    expect(page).to have_content('O campo deve ser preenchido')
  end

  scenario 'and must be unique' do
    user = create(:user)
    login_as(user)

    Subsidiary.create!(name: 'Unidade SP', cnpj:'92.123.674/0001-00', address: 'Av. Paulista, 1000')
    
    visit new_subsidiary_path
    
    fill_in 'Nome', with: 'Unidade SP'
    fill_in 'CNPJ', with: '43.466.839/0001-22'
    fill_in 'Endereço', with: 'Av. Paulista, 1527'

    click_on 'Enviar'

    expect(page).to have_content('Nome já esta em uso')
  end

  scenario 'and no have access to subsidiary' do
    visit root_path

    expect(page).not_to have_content('Filiais')
  end

  scenario 'no log in to access index' do
    visit subsidiaries_path 

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'access create with a no admin user' do
    user = create(:user, role: :employee)
    login_as(user)
    
    visit new_subsidiary_path 

    expect(current_path).to eq(root_path)
  end

  scenario 'access update with a no admin user' do
    user = create(:user, role: :employee)
    login_as(user)

    subsidiary = Subsidiary.create!(name: 'Unidade SP', cnpj:'92.123.674/0001-00', 
                                    address: 'Av. Paulista, 1000')
    
    visit edit_manufacturer_path(subsidiary) 

    expect(current_path).to eq(root_path)
  end
end