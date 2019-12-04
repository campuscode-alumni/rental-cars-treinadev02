require 'rails_helper'

feature 'Admin edit subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Vila Mariana', cnpj: '56.420.114/0001-45',
                       address: 'Rua Domingos de Morais, 1000')
    visit root_path
    click_on 'Filiais'
    click_on 'Vila Mariana'
    click_on 'Editar'

    fill_in 'Nome', with: 'Vila Matilde'
    fill_in 'CNPJ', with: '56.420.114/0001-47'
    fill_in 'Endereço', with: 'Rua Domingos de Morais, 1002'
    click_on 'Enviar'

    expect(page).to have_content 'Filial Vila Matilde'
    expect(page).to have_content 'CNPJ: 56.420.114/0001-47'
    expect(page).to have_content 'Endereço: Rua Domingos de Morais, 1002'
  end

  scenario 'and must fill in all fields' do
    Subsidiary.create!(name: 'Vila Mariana', cnpj: '56.420.114/0001-45',
                       address: 'Rua Domingos de Morais, 1000')

    visit root_path
    click_on 'Filiais'
    click_on 'Vila Mariana'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
  end
end
