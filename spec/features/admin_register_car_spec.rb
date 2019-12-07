require 'rails_helper'

feature 'Admin register a car' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)
        
        manufacturer = Manufacturer.create!(name: 'Chevrolet')

        car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                                       third_party_insurance: 90)
       
        Subsidiary.create!(name: 'RentalCar BA', cnpj: '000.000.000-00',
                           address: 'Av. Tiradentes,1000')

        CarModel.create!(name: 'Onix', year: '2020', fuel_type: 'Flex',motorization: '1.0',
                         manufacturer_id: manufacturer.id, car_category_id: car_category.id)

        visit root_path
        click_on 'Carros'
        click_on 'Registra carro'

        fill_in 'Placa', with: 'AAA-1234'
        fill_in 'Cor', with: 'Preto'
        fill_in 'Quilometragem', with: '1000'
        select 'RentalCar BA', from: 'Filial'
        select 'Onix', from: 'Modelo'

        click_on 'Enviar'

        expect(page).to have_content('Carro cadastrado com sucesso')
        expect(page).to have_content('AAA-1234')
        expect(page).to have_content('Preto')
        expect(page).to have_content('1000')
        expect(page).to have_content('RentalCar BA')
        expect(page).to have_content('Onix')

        click_on 'Voltar'

        expect(current_path).to eq root_path
    end

    scenario 'and must fill in all fiedls' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)
        
        visit new_car_path

        click_on 'Enviar'

        expect(page).to have_content('O campo deve ser preenchido')
    end

    scenario 'and license plate must be unique' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)
        
        manufacturer = Manufacturer.create!(name: 'Chevrolet')

        car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                                       third_party_insurance: 90)
 
        subsidiary = Subsidiary.create!(name: 'RentalCar BA', cnpj: '000.000.000-00',
                           address: 'Av. Tiradentes,1000')

        car_model = CarModel.create!(name: 'Onix', year: '2020', fuel_type: 'Flex',motorization: '1.0',
                         manufacturer_id: manufacturer.id, car_category_id: car_category.id)

        Car.create!(license_plate: 'ABC-1234', color: 'Preto', mileage: '1000', 
                    subsidiary_id: subsidiary.id, car_model_id: car_model.id)

        visit new_car_path

        fill_in 'Placa', with: 'ABC-1234'
        fill_in 'Cor', with: 'Azul'
        fill_in 'Quilometragem', with: '0'
        select 'RentalCar BA', from: 'Filial'
        select 'Onix', from: 'Modelo'

        click_on 'Enviar'

        expect(page).to have_content('Placa já cadastrada')
    end

    scenario 'and mileage must be zero or be bigger' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)
        
        manufacturer = Manufacturer.create!(name: 'Chevrolet')

        car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                                       third_party_insurance: 90)
       
        Subsidiary.create!(name: 'RentalCar BA', cnpj: '000.000.000-00',
                           address: 'Av. Tiradentes,1000')
        

        CarModel.create!(name: 'Onix', year: '2020', fuel_type: 'Flex',motorization: '1.0',
                         manufacturer_id: manufacturer.id, car_category_id: car_category.id)

        visit new_car_path

        fill_in 'Placa', with: 'ABC-1234'
        fill_in 'Cor', with: 'Azul'
        fill_in 'Quilometragem', with: '-150'
        select 'RentalCar BA', from: 'Filial'
        select 'Onix', from: 'Modelo'

        click_on 'Enviar'

        expect(page).to have_content('Valor deve ser maior ou igual a zero')
    end

    scenario 'and no have access to car' do
        visit root_path
    
        expect(page).not_to have_content('Carros')
      end
    
      scenario 'no log in to access index' do
        visit cars_path 
    
        expect(current_path).to eq(new_user_session_path)
      end
    
      scenario 'access create with a no admin user' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789')
        login_as(user)
        
        visit new_car_path 
    
        expect(current_path).to eq(root_path)
      end
    
end