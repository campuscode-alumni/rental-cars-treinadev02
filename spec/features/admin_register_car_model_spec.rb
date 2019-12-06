require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Chevrolet')
    Manufacturer.create!(name: 'Honda')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarCategory.create!(name: 'B', daily_rate: 200, car_insurance: 150,
                        third_party_insurance: 190)

    visit root_path
    click_on 'Modelos de Carro'
    click_on 'Registrar novo modelo'
    fill_in 'Nome', with: 'Onix'
    fill_in 'Ano', with: '2020'
    fill_in 'Motorização', with: '1.0'
    fill_in 'Combustível', with: 'Flex'
    select 'Chevrolet', from: 'Fabricante'
    select 'A', from: 'Categoria'

    click_on 'Enviar'

    expect(page).to have_content('Modelo registrado com sucesso')
    expect(page).to have_css('h1', text: 'Onix')
    expect(page).to have_content('Ano: 2020')
    expect(page).to have_content('Fabricante: Chevrolet')
    expect(page).to have_content('Categoria: A')
  end

  scenario 'and must fill in all fields' do
    visit new_car_model_path

    click_on 'Enviar'

    expect(page).to have_content('O campo deve ser preenchido')
  end

  scenario 'and name must be unique' do
    manufacturer = Manufacturer.new(name: 'Chevrolet')
    manufacturer.save! 
    car_category = CarCategory.new(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    car_category.save!

    CarModel.create!(name: 'Onix', year: 2020, motorization: '1.5', fuel_type:'Flex',
                                 manufacturer_id:manufacturer.id, car_category_id: car_category.id)

    visit new_car_model_path
    
    fill_in 'Nome', with: 'Onix'
    fill_in 'Ano', with: '2020'
    fill_in 'Motorização', with: '1.0'
    fill_in 'Combustível', with: 'Flex'
    select 'Chevrolet', from: 'Fabricante'
    select 'A', from: 'Categoria'

    click_on 'Enviar'

    expect(page).to have_content('O modelo já existe')
  end

  scenario 'and year must be bigger than 1980' do
    Manufacturer.create!(name: 'Chevrolet')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    
    visit new_car_model_path
    
    fill_in 'Nome', with: 'Onix'
    fill_in 'Ano', with: '1500'
    fill_in 'Motorização', with: '1.0'
    fill_in 'Combustível', with: 'Flex'
    select 'Chevrolet', from: 'Fabricante'
    select 'A', from: 'Categoria'

    click_on 'Enviar'

    expect(page).to have_content('Ano deve ser maior que 1980')
  end

end