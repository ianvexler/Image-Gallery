require 'rails_helper'

RSpec.describe 'create user and session', type: :system do

    # Signup testing
    scenario 'empty signup credentials' do
        visit sign_up_path
        click_button 'Signup'

        # Should show 3 error messages
        expect(page).to have_content('3 errors prohibited this user from being saved:')
    end

    scenario 'valid signup credentials' do
        visit sign_up_path

        fill_in 'email', with: 'email'
        fill_in 'username', with: 'username'
        fill_in 'password', with: 'password'
        fill_in 'confirm_password', with: 'password'
        click_button 'Signup'

        # Should take you to the login page
        expect(page).to have_content('Login')
    end

    scenario 'tries to create an existing user' do
        # Creates a user in the db
        User.create(email: 'email', username: 'username', password: 'password', password_confirmation: 'password')

        visit sign_up_path

        fill_in 'email', with: 'email'
        fill_in 'username', with: 'username'
        fill_in 'password', with: 'password'
        fill_in 'confirm_password', with: 'password'
        click_button 'Signup'

        # Should show 2 error messages
        expect(page).to have_content('2 errors prohibited this user from being saved:')
    end

    # Login testing
    scenario 'empty login credentials' do
        visit login_path
        click_button 'Login'

        # Should show 2 error messages
        expect(page).to have_content('2 errors prohibited this user to login:')
    end

    # Login testing
    scenario 'login with correct credentials' do
        test_login

        # Should take you to All Galleries
        expect(page).to have_content('Welcome to Image Gallery')
    end

    # Logout testing
    scenario 'logout' do
        test_login
        
        click_on('Logout')
        
        # Should show the login button
        expect(page).to have_content('Login')
    end

    scenario 'edit user' do
        test_login
        
        visit '/users/1/edit'

        fill_in 'email', with: 'email2'
        fill_in 'username', with: 'username2'
        fill_in 'password', with: 'password'
        fill_in 'confirm_password', with: 'password'
        click_button 'Signup'
        
        # Should show the updated credentials
        expect(page).to have_content('email2')
        expect(page).to have_content('username2')
    end
end