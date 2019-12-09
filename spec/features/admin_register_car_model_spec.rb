require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    user = create(:user)
    login_as(user)
    
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
    user = create(:user)
    login_as(user)
        
    visit new_car_model_path

    click_on 'Enviar'

    expect(page).to have_content('O campo deve ser preenchido')
  end

  scenario 'and name must be unique' do
    user = create(:user)
    login_as(user)
    
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)

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
    user = create(:user)
    login_as(user)
    
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

  scenario 'and no have access to manufacturer' do
    visit root_path

    expect(page).not_to have_content('Modelos de Carro')
  end

  scenario 'no log in to access index' do
    visit car_models_path 

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'access create with a no admin user' do
    user = create(:user, role: :employee)
    login_as(user)
    
    visit new_car_model_path 

    expect(current_path).to eq(root_path)
  end

  scenario 'access update with a no admin user' do
    user = create(:user, role: :employee)
    login_as(user)

    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)

    car_model = CarModel.create!(name: 'Onix', year: 2020, motorization: '1.5', fuel_type:'Flex',
                                 manufacturer_id:manufacturer.id, car_category_id: car_category.id)
    
    visit edit_manufacturer_path(car_model) 

    expect(current_path).to eq(root_path)
  end
end