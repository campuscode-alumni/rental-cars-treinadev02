require 'rails_helper'

feature 'Admin view car_categories' do
  scenario 'successfully' do
    #Arrange
    CarCategory.create!(name: 'Compacto', daily_rate: 39.00,
                       car_insurance: 19.00, third_party_insurance: 14.00)
    #Act
    visit root_path
    click_on 'Categorias'
    #Assert
    expect(page).to have_content('Compacto')
    expect(page).to have_content(39.00)
    expect(page).to have_content(19.00)
    expect(page).to have_content(14.00)
  end

  scenario 'and car_categories are not registered' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Não existem filiais cadastradas no '\
                                  'sistema.')

  end
end
