require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    manufacturer = Manufacturer.new(name: 'Chevrolet')
    manufacturer.save

    car_category = CarCategory.new(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarCategory.create!(name: 'B', daily_rate: 115, car_insurance: 55,
                            third_party_insurance: 120)
    car_category.save

    CarModel.create!(name: 'Onix', year: '2020', motorization: '1.0', fuel_type: 'Flex',
                     manufacturer_id: manufacturer.id, car_category_id: car_category.id)
    

    visit root_path
    click_on 'Modelos de Carro'
    click_on 'Onix'
    click_on 'Editar'
    fill_in 'Nome', with: 'Cruze'
    fill_in 'Ano', with: '2018'
    fill_in 'Motorização', with: '1.8'
    fill_in 'Combustível', with: 'Gásolina'
    select 'Chevrolet', from: 'Fabricante'
    select 'B', from: 'Categoria'

    click_on 'Enviar'

    expect(page).to have_content('Modelo alterado com sucesso')
    expect(page).to have_css('h1', text: 'Cruze')
    expect(page).to have_content('Ano: 2018')
    expect(page).to have_content('Fabricante: Chevrolet')
    expect(page).to have_content('Categoria: B')
  end
end