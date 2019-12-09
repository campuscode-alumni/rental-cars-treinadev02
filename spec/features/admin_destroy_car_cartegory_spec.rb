require 'rails_helper'

feature 'Admin delete a car category' do
    scenario 'successfully' do
        user = create(:user)
        login_as(user)
        
        CarCategory.create(name:'Carro de passeio leve', daily_rate: '60', 
                           car_insurance:'40',third_party_insurance: '25.9') 
                           
        visit car_categories_path
        click_on 'Carro de passeio leve'
        click_on 'Remover'

        expect(page).to_not have_content('Carro de passeio leve')
        expect(page).to have_content('Categoria de carro removida com sucesso')
    end

    scenario 'and try to delete without login' do
        car_category = CarCategory.create(name:'Carro de passeio leve', daily_rate: '60', 
                                          car_insurance:'40',third_party_insurance: '25.9') 
        
        visit car_category_path(car_category)

        expect(current_path).to eq(new_user_session_path)
    end
end