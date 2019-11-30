require 'rails_helper'

feature 'Visitor view subsidiaries' do
  scenario 'successfully' do
    CarCategory.create(name: 'Carro pequeno', daily_rate: '55' , car_insurance: '35', 
                       third_party_insurance: '28')

    visit root_path
    click_on 'Categorias de carro'
    click_on 'Carro pequeno'

    expect(page).to have_content('Carro pequeno')
    expect(page).to have_content('55')
    expect(page).to have_content('35')
    expect(page).to have_content('28')
  end

  scenario 'and check a list of car category' do
    CarCategory.create(name: 'Carro pequeno', daily_rate: '55' , car_insurance: '35', 
                       third_party_insurance: '28')
    CarCategory.create(name: 'Carro grande', daily_rate: '72' , car_insurance: '38', 
                       third_party_insurance: '30')
    CarCategory.create(name: 'Minivan', daily_rate: '76' , car_insurance: '40', 
                       third_party_insurance: '30')

    visit root_path
    click_on 'Categorias de carro'

    expect(page).to have_content('Carro pequeno')
    expect(page).to have_content('Carro grande')
    expect(page).to have_content('Minivan')    
  end

  scenario 'and return to home page' do
    CarCategory.create(name: 'Carro pequeno', daily_rate: '55' , car_insurance: '35', 
                       third_party_insurance: '28')

    visit root_path
    click_on 'Categorias de carro'
    click_on 'Carro pequeno'    
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and no-register manufacturers' do
    visit root_path
    click_on 'Categorias de carro'
      
    expect(page).to have_content('Não possui categorias de carro cadastradas.')
  end

end