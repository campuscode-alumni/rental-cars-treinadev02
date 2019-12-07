require 'rails_helper'

feature 'Admin edit a car' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)
        
        manufacturer = Manufacturer.new(name: 'Chevrolet')
        manufacturer.save

        car_category = CarCategory.new(name: 'A', daily_rate: 100, car_insurance: 50,
                                       third_party_insurance: 90)
        car_category.save!
        
        subsidiary = Subsidiary.new(name: 'RentalCar BA', cnpj: '000.000.000-00',
                           address: 'Av. Tiradentes,1000')
        subsidiary.save!

        Subsidiary.create!(name: 'RentalCar SP', cnpj: '000.000.000-00',
            address: 'Av. Paulista, 152')

        car_model = CarModel.new(name: 'Onix', year: '2020', fuel_type: 'Flex',motorization: '1.0',
                         manufacturer_id: manufacturer.id, car_category_id: car_category.id)
        car_model.save!

        CarModel.create!(name: 'Cruzer', year: '2018', fuel_type: 'Gásolina',motorization: '1.8',
            manufacturer_id: manufacturer.id, car_category_id: car_category.id)

        Car.create!(license_plate: 'AAA-1111', color: 'Azul', mileage: '0', 
                    subsidiary_id:subsidiary.id, car_model_id: car_model.id)

        visit root_path
        click_on 'Carros'
        click_on 'AAA-1111'
        click_on 'Editar'

        fill_in 'Placa', with: 'BBB-1234'
        fill_in 'Cor', with: 'Vermelho'
        fill_in 'Quilometragem', with: '1000'
        select 'RentalCar SP', from: 'Filial'
        select 'Cruzer', from: 'Modelo'

        click_on 'Enviar'

        expect(page).to have_content('Carro alterado com sucesso')
        expect(page).to have_content('BBB-1234')
        expect(page).to have_content('Vermelho')
        expect(page).to have_content('1000')
        expect(page).to have_content('RentalCar SP')
        expect(page).to have_content('Cruzer')

        click_on 'Voltar'

        expect(current_path).to eq root_path
    end

    scenario 'and must fill in all fiedls' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)
        
        manufacturer = Manufacturer.new(name: 'Chevrolet')
        manufacturer.save!

        car_category = CarCategory.new(name: 'A', daily_rate: 100, car_insurance: 50,
                                       third_party_insurance: 90)
        car_category.save!
        
        subsidiary = Subsidiary.new(name: 'RentalCar BA', cnpj: '000.000.000-00',
                           address: 'Av. Tiradentes,1000')
        subsidiary.save!

        car_model = CarModel.new(name: 'Onix', year: '2020', fuel_type: 'Flex',motorization: '1.0',
                         manufacturer_id: manufacturer.id, car_category_id: car_category.id)
        car_model.save!

        Car.create!(license_plate: 'ABC-1234', color: 'Preto', mileage: '1000', 
                    subsidiary_id: subsidiary.id, car_model_id: car_model.id)
        
        visit cars_path

        click_on 'ABC-1234'
        click_on 'Editar'

        fill_in 'Placa', with: ''
        fill_in 'Cor', with: ''
        fill_in 'Quilometragem', with: ''

        click_on 'Enviar'

        expect(page).to have_content('O campo deve ser preenchido')
    end

    scenario 'and license plate must be unique' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)
        
        manufacturer = Manufacturer.new(name: 'Chevrolet')
        manufacturer.save!

        car_category = CarCategory.new(name: 'A', daily_rate: 100, car_insurance: 50,
                                       third_party_insurance: 90)
        car_category.save!
        
        subsidiary = Subsidiary.new(name: 'RentalCar BA', cnpj: '000.000.000-00',
                           address: 'Av. Tiradentes,1000')
        subsidiary.save!

        car_model = CarModel.new(name: 'Onix', year: '2020', fuel_type: 'Flex',motorization: '1.0',
                         manufacturer_id: manufacturer.id, car_category_id: car_category.id)
        car_model.save!

        Car.create!(license_plate: 'ABC-1234', color: 'Preto', mileage: '1000', 
                    subsidiary_id: subsidiary.id, car_model_id: car_model.id)

        Car.create!(license_plate: 'XYZ-6789', color: 'Azul', mileage: '1000', 
                        subsidiary_id: subsidiary.id, car_model_id: car_model.id)
        
        visit cars_path
        
        click_on 'ABC-1234'
        click_on 'Editar'

        fill_in 'Placa', with: 'XYZ-6789'

        click_on 'Enviar'

        expect(page).to have_content('Placa já cadastrada')
    end

    scenario 'and mileage must be zero or be bigger' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789', role: :admin)
        login_as(user)
        
        manufacturer = Manufacturer.new(name: 'Chevrolet')
        manufacturer.save!

        car_category = CarCategory.new(name: 'A', daily_rate: 100, car_insurance: 50,
                                       third_party_insurance: 90)
        car_category.save!
        
        subsidiary = Subsidiary.new(name: 'RentalCar BA', cnpj: '000.000.000-00',
                           address: 'Av. Tiradentes,1000')
        subsidiary.save!

        car_model = CarModel.new(name: 'Onix', year: '2020', fuel_type: 'Flex',motorization: '1.0',
                         manufacturer_id: manufacturer.id, car_category_id: car_category.id)
        car_model.save!

        Car.create!(license_plate: 'ABC-1234', color: 'Preto', mileage: '1000', 
                    subsidiary_id: subsidiary.id, car_model_id: car_model.id)

        visit cars_path
        
        click_on 'ABC-1234'
        click_on 'Editar'

        fill_in 'Quilometragem', with: '-150'

        click_on 'Enviar'

        expect(page).to have_content('Valor deve ser maior ou igual a zero')
    end

    scenario 'access update with a no admin user' do
        user = User.create!(email: 'teste@teste.com.br', password:'123456789')
        login_as(user)
    
        manufacturer = Manufacturer.create!(name: 'Chevrolet')

        car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                                       third_party_insurance: 90)
 
        subsidiary = Subsidiary.create!(name: 'RentalCar BA', cnpj: '000.000.000-00',
                           address: 'Av. Tiradentes,1000')

        car_model = CarModel.create!(name: 'Onix', year: '2020', fuel_type: 'Flex',motorization: '1.0',
                         manufacturer_id: manufacturer.id, car_category_id: car_category.id)

        car= Car.create!(license_plate: 'ABC-1234', color: 'Preto', mileage: '1000', 
                    subsidiary_id: subsidiary.id, car_model_id: car_model.id)
        
        visit edit_car_path(car) 
    
        expect(current_path).to eq(root_path)
      end
end