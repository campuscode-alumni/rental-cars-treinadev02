require 'rails_helper'

feature 'Admin register car category' do
  scenario 'successfully' do
    visit root_path
    click_on 'Categorias de carro'
    click_on 'Registrar nova categoria'

    fill_in 'Nome', with: 'Carro pequeno'
    fill_in 'Diária', with: '52'
    fill_in 'Seguro', with: '30.99'
    fill_in 'Seguro de terceiros', with: '38.9'
    
    click_on 'Enviar'

    expect(page).to have_content('Carro pequeno')
    expect(page).to have_content('52')
    expect(page).to have_content('30.99')
    expect(page).to have_content('38.9')
  end
end