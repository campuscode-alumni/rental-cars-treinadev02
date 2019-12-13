require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully and return to home page' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'

    expect(page).to have_content('Fiat')

    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  scenario 'and visitor can no see register, edit and remove button' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')

    visit root_path
    click_on 'Fabricantes'

    expect(page).not_to have_content('Registrar novo fabricante')

    click_on 'Fiat'

    expect(page).not_to have_content('Editar')
    expect(page).not_to have_content('Deletar')
  end



end