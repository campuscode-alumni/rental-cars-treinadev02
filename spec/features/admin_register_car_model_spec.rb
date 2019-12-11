require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Chevrolet')
    Manufacturer.create!(name: 'Honda')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarCategory.create!(name: 'B', daily_rate: 200, car_insurance: 150,
                        third_party_insurance: 190)
    admin = User.create!(email: 'test@test.com', password: '123456',
                         role: :admin)

    login_as(admin, scope: :user)
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

  scenario 'validate mandatory fields' do
    Manufacturer.create!(name: 'Chevrolet')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    admin = User.create!(email: 'test@test.com', password: '123456',
                         role: :admin)

    login_as(admin, scope: :user)
    visit root_path
    click_on 'Modelos de Carro'
    click_on 'Registrar novo modelo'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Erro')
  end

  scenario 'and must be admin' do
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :employee)

    login_as(user, scope: :user)
    visit new_car_model_path

    expect(page).to have_content('Você não tem autorização para realizar '\
                                 'esta ação')
    expect(current_path).to eq root_path
  end
end
