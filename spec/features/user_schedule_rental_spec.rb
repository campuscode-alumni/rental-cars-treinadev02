require 'rails_helper'

feature 'user schedule rental' do
  scenario 'successfully' do
    subsidiary = Subsidiary.create!(name: 'Almeidinha Cars',
                                    cnpj: '00.000.000/0000-00',
                                    address: 'Alameda Santos, 1293')
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :employee)
    client = Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com',
                            document: '743.341.870-99')
    category = CarCategory.create!(name: 'A', daily_rate: 30,
                                   car_insurance: 30, third_party_insurance: 30)
    manufacturer = Manufacturer.create!(name: 'Fiat')
    car_model = CarModel.create!(name: 'Onix', year: 2000,
                                 manufacturer: manufacturer, fuel_type: 'Flex',
                                 motorization: '1.0',
                                 car_category: category)
    Car.create!(car_model: car_model, license_plate: 'ABC1234',
                color: 'Verde', mileage: 0, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    fill_in 'Data de início', with: Date.current
    fill_in 'Data de fim', with: 2.days.from_now
    select "#{client.name} - #{client.document}", from: 'Cliente'
    select category.name, from: 'Categoria do Carro'
    click_on 'Enviar'

    expect(page).to have_content('Locação agendada com sucesso')
    expect(page).to have_content('Data de início: '\
                                 "#{Date.current.strftime('%d/%m/%Y')}")
    expect(page).to have_content('Data de fim: '\
                                 "#{2.days.from_now.strftime('%d/%m/%Y')}")
    expect(page).to have_content('Cliente')
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.document)
    expect(page).to have_content('Categoria')
    expect(page).to have_content(category.name)
  end

  scenario 'and must fill all fields' do
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :employee)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para '\
                                 'continuar')
    expect(page).to have_content('Data de início não pode ficar em branco')
    expect(page).to have_content('Data de fim não pode ficar em branco')
    expect(page).to have_content('Client must exist')
    expect(page).to have_content('Car category must exist')
    # expect(page).to have_content('Cliente deve existir')
    # expect(page).to have_content('Categoria deve existir')
  end

  scenario 'and start date must be less to end date' do
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
    fill_in 'Data de fim', with: '07/12/2019'
    select "#{client.name} - #{client.document}", from: 'Cliente'
    select category.name, from: 'Categoria do Carro'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para '\
                                 'continuar')
    expect(page).to have_content('End date deve ser maior que data de início')
  end

  scenario 'and start date eual or greater than today' do
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
    fill_in 'Data de fim', with: '10/12/2019'
    select "#{client.name} - #{client.document}", from: 'Cliente'
    select category.name, from: 'Categoria do Carro'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para '\
                                 'continuar')
    expect(page).to have_content('deve ser maior que a data de hoje.')
  end

  scenario 'and has no cars available' do
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
    fill_in 'Data de fim', with: '07/12/2019'
    select "#{client.name} - #{client.document}", from: 'Cliente'
    select category.name, from: 'Categoria do Carro'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para '\
                                 'continuar')
    expect(page).to have_content('Não há carros disponíveis na '\
                                 'categoria escolhida')
  end
end
