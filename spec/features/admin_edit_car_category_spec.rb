require 'rails_helper'

feature 'Admin edits car category' do
    scenario 'successfully' do
      user = create(:user)
      login_as(user)
      
      CarCategory.create(name:'Carro de passeio leve', daily_rate: '60', car_insurance:'40',
                         third_party_insurance: '25.9')
      
      visit root_path
      click_on 'Categorias de carro'
      click_on 'Carro de passeio leve'
      click_on 'Editar'
  
      fill_in 'Nome', with: 'Carro pequeno'
      fill_in 'Diária', with: '50'
      fill_in 'Seguro', with: '20'
      fill_in 'Seguro de terceiros', with: '20'
      
      click_on 'Enviar'
  
      expect(page).to have_content('Carro pequeno')
      expect(page).to have_content('50')
      expect(page).to have_content('20')
      expect(page).to have_content('20')
      expect(page).to have_content('Categoria de carro alterada com sucesso')
    end

    scenario 'and must fill in all fiedls' do
      user = create(:user)
      login_as(user)
      
      CarCategory.create!(name: 'Carro pequeno', daily_rate: '50', car_insurance: '25', 
                         third_party_insurance: '15')
         
      visit car_categories_path
      
      click_on 'Carro pequeno'
      click_on 'Editar'
      fill_in 'Nome', with: ''
      fill_in 'Diária', with: ''
      fill_in 'Seguro', with: ''
      fill_in 'Seguro de terceiros', with: ''
      click_on 'Enviar'
  
      expect(page).to have_content('O campo deve ser preenchido')
      expect(page).to have_content('Valor deve ser maior que zero')
    end
    
    scenario 'and must be unique' do
      user = create(:user)
      login_as(user)
      
      CarCategory.create!(name: 'Carro pequeno', daily_rate: '50', car_insurance: '25', 
                         third_party_insurance: '15')
      CarCategory.create!(name: 'Carro grande', daily_rate: '70', car_insurance: '32', 
                         third_party_insurance: '18')
      
      visit car_categories_path
      
      click_on 'Carro pequeno'
      click_on 'Editar'
      fill_in 'Nome', with: 'Carro grande'
          
      click_on 'Enviar'
  
      expect(page).to have_content('O nome deve ser unico')
    end
    
    scenario 'and price must be a posite number' do
      user = create(:user)
      login_as(user)
      
      CarCategory.create!(name: 'Carro pequeno', daily_rate: '50', car_insurance: '25', 
                         third_party_insurance: '15')
      
      visit car_categories_path
      
      click_on 'Carro pequeno'
      click_on 'Editar'
    
      fill_in 'Diária', with: '-10'
      fill_in 'Seguro', with: '-50'
      fill_in 'Seguro de terceiros', with: '-12'
      click_on 'Enviar'
    
      expect(page).to have_content('Valor deve ser maior que zero')
    end

    scenario 'access update with a no admin user' do
      user = create(:user, role: :employee)
      login_as(user)
  
      car_category = CarCategory.create!(name: 'Carro pequeno', daily_rate: '50', car_insurance: '25', 
                                         third_party_insurance: '15')
      
      visit edit_car_path(car_category)
  
      expect(current_path).to eq(root_path)
    end
end