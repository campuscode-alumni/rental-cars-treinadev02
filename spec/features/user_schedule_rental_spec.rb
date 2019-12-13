require 'rails_helper'

feature 'User schedule a rental' do
    scenario 'successfully' do
        user = create(:user)
        login_as(user)
        
        rental = create(:rental)

        visit root_path
        click_on 'Locação'
        click_on 'AAA1111'

        #select car.license_plate, from: 'Carro'

        click_on 'Efetiva Locação'

        expect(page).to have_content('Em progresso')
    end
end