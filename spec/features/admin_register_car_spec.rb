require 'rails_helper'

feature 'Admin register car' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Carros3', cnpj: '123456789012345678', address: 'Rua dos Pombos')
    Manufacturer.create!(name: 'GM')
    CarCategory.create!(name: 'A', daily_rate: 90, car_insurance: 50,
                        third_party_insurance: 40)
    CarModel.create!(name: 'Onix', fuel_type: 'flex', motorization: '1.0', year: '2018', manufacturer_id: 1, car_category_id: 1)
    admin = User.create!(email: 'test@test.com', password: '123456',
                         role: :admin)

    login_as(admin, scope: :user)

    visit root_path
    click_on 'Carros'
    click_on 'Registrar Carros'

    fill_in 'Placa', with: 'ABC-1234'
    fill_in 'Cor', with: 'Verde'
    select 'Onix', from: 'Modelo'
    fill_in 'Quilometragem', with: '200'
    select 'Carros3', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('ABC-1234')
    expect(page).to have_content('Verde')
    expect(page).to have_content('Onix')
    expect(page).to have_content( '200')
    expect(page).to have_content('Carros3')
  end
end
