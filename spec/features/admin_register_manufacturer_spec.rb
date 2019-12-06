require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    
    user = User.create!(email: 'teste@teste.com.br', password:'123456789')
    login_as(user, scope: user)

    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
    expect(page).to have_content('Fabricante cadastrado com sucesso')
  end

  scenario 'and must fill in all fiedls' do
    visit new_manufacturer_path

    click_on 'Enviar'
    
    expect(page).to have_content('O campo deve ser preenchido')
  end

  scenario 'and must be unique' do
    Manufacturer.create!(name: 'Fiat')
    
    visit new_manufacturer_path

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'
    
    expect(page).to have_content('Nome já esta em uso')
  end

  scenario 'must be admin' do

  

end