require 'rails_helper'

feature 'Visitor view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create(name: 'RentalCars PE', cnpj: '77.286.360/0001-26' ,
                      address: 'Rua Severino Juliano da Silva, 123')

    visit root_path
    click_on 'Filiais'
    click_on 'RentalCars PE'

    expect(page).to have_content('RentalCars PE')
    expect(page).to have_content('77.286.360/0001-26')
    expect(page).to have_content('Rua Severino Juliano da Silva, 123')
  end

  scenario 'and go back to the root' do
    Subsidiary.create(name: 'RentalCars PE', cnpj: '77.286.360/0001-26' ,
                      address: 'Rua Severino Juliano da Silva, 123')

    visit root_path
    click_on 'Filiais'
    click_on 'RentalCars PE'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and check a list of subsidiary' do
    Subsidiary.create(name: 'RentalCars PE', cnpj: '77.286.360/0001-26' ,
                      address: 'Rua Severino Juliano da Silva, 123')
    Subsidiary.create(name: 'RentalCars BA', cnpj: '82.272.928/0001-90' , 
                      address: 'Praça Manoel Vitorino, 168')
    Subsidiary.create(name: 'RentalCars SP', cnpj: '75.856.882/0001-90' , 
                      address: 'Av. Paulista, 1000')

    visit root_path
    click_on 'Filiais'
        
    expect(page).to have_content('RentalCars BA')
    expect(page).to have_content('RentalCars PE')
    expect(page).to have_content('RentalCars SP')
  end

  scenario 'and no-register manufacturers' do
    visit root_path
    click_on 'Fabricantes'
      
    expect(page).to have_content('Não possui fabricantes cadastradas.')
  end

end