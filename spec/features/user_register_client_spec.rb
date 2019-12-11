require 'rails_helper'

feature 'User register client' do
  scenario 'successfully' do
    admin = User.create!(email: 'test@test.com', password: '123456',
                         role: :admin)

    login_as(admin, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Nome', with: 'Fulano Sicrano'
    fill_in 'CPF', with: '354.396.540-97'
    click_on 'Enviar'

    expect(page).to have_content('test@test.com')
    expect(page).to have_content('Fulano Sicrano')
    expect(page).to have_content('354.396.540-97')
    expect(page).to have_content('Cliente registrado com sucesso')
  end

  scenario 'and must fill in all fields' do
    admin = User.create!(email: 'test@test.com', password: '123456',
                         role: :admin)

    login_as(admin, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'
    click_on 'Enviar'

    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
  end
end
