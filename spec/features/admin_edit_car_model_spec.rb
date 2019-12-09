require 'rails_helper'

feature 'Admin edit car model' do
  scenario 'successfully' do
    user = create(:user)
    login_as(user)

    manufacturer = Manufacturer.create!(name: 'Chevrolet')

    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarCategory.create!(name: 'B', daily_rate: 115, car_insurance: 55,
                            third_party_insurance: 120)
                            
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

  scenario 'access update without a admin user' do
    user = create(:user, role: :employee)
    login_as(user)

    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    
    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    car_model = CarModel.create!(name: 'Onix', year: '2020', motorization: '1.0', fuel_type: 'Flex',
                     manufacturer_id: manufacturer.id, car_category_id: car_category.id)
    
    visit edit_car_model_path(car_model) 

    expect(current_path).to eq(root_path)
  end

end