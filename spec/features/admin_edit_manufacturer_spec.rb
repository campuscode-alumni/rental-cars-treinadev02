require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    user = create(:user)
    login_as(user)
    
    Manufacturer.create(name: 'Fiat')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Honda')
    expect(page).to have_content('Fabricante atualizado com sucesso')
  end

  scenario 'and must fill in all fiedls' do
    user = create(:user)
    login_as(user)
    
    Manufacturer.create!(name: 'Fiat')
    
    visit manufacturers_path
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content('O campo deve ser preenchido')
  end

  scenario 'and must be unique' do
    user = create(:user)
    login_as(user)
    
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Honda')
    
    visit manufacturers_path
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'
    
    expect(page).to have_content('Nome já esta em uso')
  end

  scenario 'access update with a no admin user' do
    user = create(:user, role: :employee)
    login_as(user)

    manufacturer = Manufacturer.create!(name: 'Fiat')
    
    visit edit_manufacturer_path(manufacturer) 

    expect(current_path).to eq(root_path)
  end  

  
end