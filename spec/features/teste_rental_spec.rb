feature 'user start rental' do
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
    car = Car.create!(car_model: car_model, license_plate: 'ABC1234',
                      color: 'Verde', mileage: 0, subsidiary: subsidiary)
    rental = Rental.create!(start_date: 1.day.from_now,
                            end_date: 2.days.from_now,
                            client: client, car_category: category)
​
    login_as(user, scope: :user)
    visit rental_path(rental)
    select "#{car_model.name} - #{car.license_plate}", from: 'Carro'
    click_on 'Iniciar Locação'
​
    expect(page).to have_content('Locação iniciada com sucesso')
    expect(page).not_to have_link('Iniciar Locação')
    rental.reload
    car.reload
    expect(rental).to be_in_progress
    expect(car).not_to be_available
  end
end




