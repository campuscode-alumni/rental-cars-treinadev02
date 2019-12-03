require 'rails_helper'

feature 'Admin register car category' do
  scenario 'successfully' do
    visit root_path
    click_on 'Categorias de carro'
    click_on 'Registrar nova categoria'

    fill_in 'Nome', with: 'Carro pequeno'
    fill_in 'Diária', with: '52'
    fill_in 'Seguro', with: '30.99'
    fill_in 'Seguro de terceiros', with: '38.9'
    
    click_on 'Enviar'

    expect(page).to have_content('Carro pequeno')
    expect(page).to have_content('52')
    expect(page).to have_content('30.99')
    expect(page).to have_content('38.9')
  end

  scenario 'and must fill in all fiedls' do
    visit new_car_category_path

    click_on 'Enviar'

    expect(page).to have_content('O campo deve ser preenchido')
    expect(page).to have_content('Valor deve ser maior que zero')
  end

  scenario 'and must be unique' do
    CarCategory.create!(name: 'Carro pequeno', daily_rate: '50', car_insurance: '25', 
                       third_party_insurance: '15')
    
    visit new_car_category_path

    fill_in 'Nome', with: 'Carro pequeno'
    fill_in 'Diária', with: '52'
    fill_in 'Seguro', with: '30.99'
    fill_in 'Seguro de terceiros', with: '38.9'

    click_on 'Enviar'

    expect(page).to have_content('O nome deve ser unico')
  end

  scenario 'and price must be a posite number' do
    CarCategory.create!(name: 'Carro pequeno', daily_rate: '50', car_insurance: '25', 
                       third_party_insurance: '15')
    
    visit new_car_category_path

    fill_in 'Nome', with: 'Carro pequeno'
    fill_in 'Diária', with: '-10'
    fill_in 'Seguro', with: '-50'
    fill_in 'Seguro de terceiros', with: '-12'

    click_on 'Enviar'

    expect(page).to have_content('Valor deve ser maior que zero')
  end
end