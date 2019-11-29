require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    #Arrange
    Subsidiary.create!(name: 'Almeidinha Cars', cnpj: '00.000.000/0000-00',
                       address: 'Alameda Santos, 1293')
    #Act
    visit root_path
    click_on 'Filiais'
    click_on 'Almeidinha Cars'
    #Assert
    expect(page).to have_content('Almeidinha Cars')
    expect(page).to have_content('00.000.000/0000-00')
    expect(page).to have_content('Alameda Santos, 1293')
  end

end
