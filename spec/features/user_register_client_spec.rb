require 'rails_helper'

feature 'User register client' do
  scenario 'successfully' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Kelly'
    fill_in 'CPF', with: '009.870.960-79'
    fill_in 'Email', with: 'kelly@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Kelly')
  end

  scenario 'and must fill in all fields' do
    visit new_client_path
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Email', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve preencher todos os campos')
  end

  scenario 'and name must be unique' do
    Client.create!(name: 'Kelly', cpf: '009.870.960-79', email: 'kelly@gmail.com')

    visit new_client_path
    fill_in 'Nome', with: 'Kelly'
    fill_in 'CPF', with: '009.870.960-79'
    fill_in 'Email', with: 'kelly@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('CPF já está em uso')
    expect(page).to have_content('Email já está em uso')
  end
end
