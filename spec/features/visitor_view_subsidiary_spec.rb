require 'rails_helper'

feature 'Visitor view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create(name: 'RentalCars BA', cnpj: '82.272.928/0001-90' , address: 'Praça Manoel Vitorino, 168')
    Subsidiary.create(name: 'RentalCars PE', cnpj: '77.286.360/0001-26' , address: 'Rua Severino Juliano da Silva, 123')

    visit root_path
    click_on 'Filiais'
    click_on 'RentalCars PE'

    expect(page).to have_content('RentalCars PE')
    expect(page).to have_content('77.286.360/0001-26')
    expect(page).to have_content('Rua Severino Juliano da Silva, 123')

    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    Subsidiary.create(name: 'RentalCars BA', cnpj: '82.272.928/0001-90' , address: 'Praça Manoel Vitorino, 168')
    Subsidiary.create(name: 'RentalCars PE', cnpj: '77.286.360/0001-26' , address: 'Rua Severino Juliano da Silva, 123')

    visit root_path
    click_on 'Filiais'
    click_on 'RentalCars PE'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end