require 'rails_helper'

feature 'Admin register car category' do
  scenario 'successfully' do
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Registrar nova categoria'

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
end
