require 'rails_helper'

feature 'Admin view car categories' do
  scenario 'successfully' do
    CarCategory.create!(name: 'A', daily_rate: 99, car_insurance: 1000,
                        third_party_insurance: 1499)
    CarCategory.create!(name: 'B', daily_rate: 149, car_insurance: 1500,
                        third_party_insurance: 1999)

    visit root_path
    click_on 'Categorias de Carros'

    expect(current_path).to eq car_categories_path
    expect(page).to have_content 'A'
    expect(page).to have_content 'B'
  end

  scenario 'and view details' do
    CarCategory.create!(name: 'A', daily_rate: 99, car_insurance: 1000,
                        third_party_insurance: 1499)
    CarCategory.create!(name: 'B', daily_rate: 149, car_insurance: 1500,
                        third_party_insurance: 1999)

    visit root_path
    click_on 'Categorias de Carros'
    click_on 'B'

    expect(page).to have_content 'Categoria B'
    expect(page).to have_content 'Diária Padrão: 149'
    expect(page).to have_content 'Seguro do Carro: 1500'
    expect(page).to have_content 'Seguro para Terceiros: 1999'
  end
end
