require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    #Arrange
    Manufacturer.new(name: 'Fiat').save
    Manufacturer.create(name: 'Volkswagen')
    user = User.create!(email: 'test@test.com', password: '123456')

    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    #Assert
    expect(page).to have_content('Fiat')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Voltar'

    expect(current_path).to eq manufacturers_path
  end
end
