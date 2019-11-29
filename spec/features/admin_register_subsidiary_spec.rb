require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
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
  end

  feature 'Admin no-register subsidiary' do
    scenario 'successfully' do
      visit root_path
      click_on 'Filiais'
      
      expect(page).to have_content('Não possui filiais cadastradas.')
    end
  

end