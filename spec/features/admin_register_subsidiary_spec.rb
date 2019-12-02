require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Almeidinha Cars'
    fill_in 'CNPJ', with: '00.000.000/0000-00'
    fill_in 'Endereço', with: 'Alameda Santos, 1293'
    click_on 'Enviar'

    expect(page).to have_content('Almeidinha Cars')
    expect(page).to have_content('00.000.000/0000-00')
    expect(page).to have_content('Alameda Santos, 1293')
  end
end
