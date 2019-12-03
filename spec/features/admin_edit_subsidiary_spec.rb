require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Almeidinha Cars', cnpj: '00.000.000/0000-00',
                       address: 'Alameda Santos, 1293')

    visit root_path
    click_on 'Filiais'
    click_on 'Almeidinha Cars'
    click_on 'Editar'
    fill_in 'Nome', with: 'Pereirinha Cars'
    click_on 'Enviar'

    expect(page).to have_content('Pereirinha Cars')
    expect(page).to have_content('Filial atualizada com sucesso')
  end

  scenario 'and must fill in all fields' do
    Subsidiary.create!(name: 'Almeidinha Cars', cnpj: '00.000.000/0000-00',
                       address: 'Alameda Santos, 1293')

    visit root_path
    click_on 'Filiais'
    click_on 'Almeidinha Cars'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'and must be unique' do
    Subsidiary.create!(name: 'Almeidinha Cars', cnpj: '00.000.000/0000-00',
                       address: 'Alameda Santos, 1293')
    Subsidiary.create!(name: 'Pereirinha Cars', cnpj: '00.564.000/0000-00',
                       address: 'jardim Santos, 93')

    visit root_path
    click_on 'Filiais'
    click_on 'Almeidinha Cars'
    click_on 'Editar'
    fill_in 'Nome', with: 'Pereirinha Cars'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end
end
