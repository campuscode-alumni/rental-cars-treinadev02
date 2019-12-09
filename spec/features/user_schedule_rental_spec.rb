require 'rails_helper'

feature 'user schedule rental' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :employee)
    client = Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com',
                            document: '743.341.870-99')
    category = CarCategory.create!(name: 'A', daily_rate: 30,
                                   car_insurance: 30, third_party_insurance: 30)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    fill_in 'Data de início', with: '09/12/2019'
    fill_in 'Data de fim', with: '12/12/2019'
    select "#{client.name} - #{client.document}", from: 'Cliente'
    select category.name, from: 'Categoria do Carro'
    click_on 'Enviar'

    expect(page).to have_content('Locação agendada com sucesso')
    expect(page).to have_content('Data de início: 09/12/2019')
    expect(page).to have_content('Data de fim: 12/12/2019')
    expect(page).to have_content('Cliente')
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.document)
    expect(page).to have_content('Categoria')
    expect(page).to have_content(category.name)
  end

  xscenario 'and must fill all fields' do
  end

  xscenario 'and start date must be less to end date' do
  end
end
