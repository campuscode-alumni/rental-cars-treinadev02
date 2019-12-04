require 'rails_helper'

feature 'Admin delete a car category' do
    scenario 'successfully' do
        CarCategory.create(name:'Carro de passeio leve', daily_rate: '60', 
                           car_insurance:'40',third_party_insurance: '25.9') 
                           
        visit car_categories_path
        click_on 'Carro de passeio leve'
        click_on 'Remover'

        expect(page).to_not have_content('Carro de passeio leve')
        expect(page).to have_content('Categoria de carro removida com sucesso')
    end
end