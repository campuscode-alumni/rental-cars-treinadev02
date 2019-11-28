require 'rails_helper'

feature 'Visitor view subsidiaries' do
  scenario 'successfully' do
    CarCategory.create(name: 'Carro pequeno', daily_rate: '55' , car_insurance: '35', third_party_insurance: '28')
    CarCategory.create(name: 'Carro grande', daily_rate: '75' , car_insurance: '45.5', third_party_insurance: '30')

    visit root_path
    click_on 'Categorias de carro'
    click_on 'Carro grande'

    expect(page).to have_content('Carro grande')
    expect(page).to have_content('75')
    expect(page).to have_content('45.5')
    expect(page).to have_content('30')

    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    CarCategory.create(name: 'Carro pequeno', daily_rate: '55' , car_insurance: '35', third_party_insurance: '28')
    CarCategory.create(name: 'Carro grande', daily_rate: '75' , car_insurance: '45.5', third_party_insurance: '30')

    visit root_path
    click_on 'Categorias de carro'
    click_on 'Carro pequeno'    
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end