require 'rails_helper'

feature 'Admin register car_category' do
  scenario 'successfully' do
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar nova categoria'

    fill_in 'Nome', with: 'Compacto'
    fill_in 'Diária', with: 39.00
    fill_in 'Seguro do carro', with: 29.00
    fill_in 'Seguradora de terceiros', with: 19.00
    click_on 'Enviar'

    expect(page).to have_content('Compacto')
    expect(page).to have_content(39.00)
    expect(page).to have_content(29.00)
    expect(page).to have_content(19.00)
  end
end
