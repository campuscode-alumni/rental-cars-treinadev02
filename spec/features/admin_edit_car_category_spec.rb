require 'rails_helper'

feature 'Admin edit car category' do
  scenario 'successfully' do
    CarCategory.create!(name: 'C', daily_rate: 200, car_insurance: 2000,
                        third_party_insurance: 3000)
    admin = User.create!(email: 'test@test.com', password: '123456',
                         role: :admin)

    login_as(admin, scope: :user)
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'C'
    click_on 'Editar'

    fill_in 'Nome', with: 'C'
    fill_in 'Diária Padrão', with: '299'
    fill_in 'Seguro do Carro', with: '2990'
    fill_in 'Seguro para Terceiros', with: '3990'
    click_on 'Enviar'

    expect(page).to have_content 'Categoria C'
    expect(page).to have_content 'Diária Padrão: 299'
    expect(page).to have_content 'Seguro do Carro: 2990'
    expect(page).to have_content 'Seguro para Terceiros: 3990'
  end

  scenario 'and must be admin' do
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :employee)
    car_category = CarCategory.create!(name: 'C', daily_rate: 200, car_insurance: 2000,
                                       third_party_insurance: 3000)

    login_as(user, scope: :user)
    visit edit_car_category_path(car_category)

    expect(page).to have_content('Você não tem autorização para realizar '\
                                 'esta ação')
    expect(current_path).to eq root_path
  end
end
