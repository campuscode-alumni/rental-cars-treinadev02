require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    admin = User.create!(email: 'test@test.com', password: '123456',
                         role: :admin)

    Subsidiary.create!(name: 'Almeidinha Cars', cnpj: '00.000.000/0000-00',
                       address: 'Alameda Santos, 1293')

    login_as(admin, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Almeidinha Cars'

    expect(page).to have_content('Almeidinha Cars')
    expect(page).to have_content('00.000.000/0000-00')
    expect(page).to have_content('Alameda Santos, 1293')
  end

  scenario 'and view subsidiaries links' do
    Subsidiary.create!(name: 'Almeidinha Cars', cnpj: '00.000.000/0000-00',
                       address: 'Alameda Santos, 1293')
    Subsidiary.create!(name: 'Almeidinha Trucks', cnpj: '00.000.000/0000-00',
                       address: 'Alameda Santos, 1293')
    admin = User.create!(email: 'test@test.com', password: '123456',
                         role: :admin)


    login_as(admin, scope: :user)
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Almeidinha Cars')
    expect(page).to have_link('Almeidinha Trucks')
  end

  scenario 'and subsidiaries are not registered' do
    admin = User.create!(email: 'test@test.com', password: '123456',
                         role: :admin)

    login_as(admin, scope: :user)
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Não existem filiais cadastradas'\
                                 ' no sistema.')
  end

  xscenario 'and must be logged in' do
    visit subsidiaries_path

    expect(current_path).to eq new_user_session_path
  end

  xscenario 'and must be logged in' do
    visit root_path

    expect(page).not_to have_link('Filiais')
  end
end
