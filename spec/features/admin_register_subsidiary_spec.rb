require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Vila Mariana'
    fill_in 'CNPJ', with: '56.420.114/0001-45'
    fill_in 'Endereço', with: 'Rua Domingos de Morais, 1000'
    click_on 'Enviar'

    expect(page).to have_content 'Filial Vila Mariana'
    expect(page).to have_content 'CNPJ: 56.420.114/0001-45'
    expect(page).to have_content 'Endereço: Rua Domingos de Morais, 1000'
  end
end
