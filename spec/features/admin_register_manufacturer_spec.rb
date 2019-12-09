require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    user = create(:user)
    login_as(user)

    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
    expect(page).to have_content('Fabricante cadastrado com sucesso')
  end

  scenario 'and must fill in all fiedls' do
    user = create(:user)
    login_as(user)

    visit new_manufacturer_path

    click_on 'Enviar'
    
    expect(page).to have_content('O campo deve ser preenchido')
  end

  scenario 'and must be unique' do
    user = create(:user)
    login_as(user)
    
    Manufacturer.create!(name: 'Fiat')
    
    visit new_manufacturer_path

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'
    
    expect(page).to have_content('Nome já esta em uso')
  end

  scenario 'access create with a no admin user' do
    user = create(:user, role: :employee)
    login_as(user)
    
    visit new_manufacturer_path 

    expect(current_path).to eq(root_path)
  end

end