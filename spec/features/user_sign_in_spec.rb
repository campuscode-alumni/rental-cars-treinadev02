require 'rails_helper'

feature 'user sign in' do
    scenario 'home page with a employee user' do
        user = create(:user,role: :employee)
        user.save!

        visit root_path

        click_on 'Entrar'

        fill_in 'Email', with: user.email
        fill_in 'Senha', with: user.password

        within('form') do
            click_on 'Entrar'
        end

        expect(current_path).to eq root_path
        expect(page).to have_content("Olá #{user.email}")
        expect(page).to have_content('Signed in successfully.')
    end

    scenario 'does not see entrar link with employee user' do
        user = create(:user,role: :employee)
        user.save! 

        visit root_path

        click_on 'Entrar'

        fill_in 'Email', with: user.email
        fill_in 'Senha', with: user.password

        within('form') do
            click_on 'Entrar'
        end

        expect(page).not_to have_content('Entrar')
        expect(page).to have_content('Sair')
    end

    scenario 'sing out with employee user' do
        user = create(:user,role: :employee)
        user.save!
        
        visit root_path

        click_on 'Entrar'

        fill_in 'Email', with: user.email
        fill_in 'Senha', with: user.password

        within('form') do
            click_on 'Entrar'
        end

        expect(current_path).to eq root_path
        expect(page).to have_content("Olá #{user.email}")
        expect(page).to have_content('Sair')

        click_on 'Sair'

        expect(page).to have_content('Signed out successfully.')
        expect(page).to have_content('Entrar')
    end

    scenario 'home page with admin user' do
        user = create(:user)
        user.save!

        visit root_path

        click_on 'Entrar'

        fill_in 'Email', with: user.email
        fill_in 'Senha', with: user.password

        within('form') do
            click_on 'Entrar'
        end

        expect(current_path).to eq root_path
        expect(page).to have_content("Olá #{user.email}")
        expect(page).to have_content('Signed in successfully.')
    end

    scenario 'does not see entrar link with admin user' do
        user = create(:user)
        user.save! 

        visit root_path

        click_on 'Entrar'

        fill_in 'Email', with: user.email
        fill_in 'Senha', with: user.password

        within('form') do
            click_on 'Entrar'
        end

        expect(page).not_to have_content('Entrar')
        expect(page).to have_content('Sair')
    end

    scenario 'sing out with admin user' do
        user = create(:user)
        user.save!
        
        visit root_path

        click_on 'Entrar'

        fill_in 'Email', with: user.email
        fill_in 'Senha', with: user.password

        within('form') do
            click_on 'Entrar'
        end

        expect(current_path).to eq root_path
        expect(page).to have_content("Olá #{user.email}")
        expect(page).to have_content('Sair')

        click_on 'Sair'

        expect(page).to have_content('Signed out successfully.')
        expect(page).to have_content('Entrar')
    end
end