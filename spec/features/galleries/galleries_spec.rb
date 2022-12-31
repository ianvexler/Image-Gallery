require 'rails_helper'

RSpec.describe 'create gallery', type: :system do
    scenario 'attempt without logging in' do
        visit galleries_path(view_name: "all_galleries")

        visit new_gallery_path

        # Should redirect to login
        expect(page).to have_content('Login')
    end

    scenario 'empty gallery credentials' do
        test_login

        visit galleries_path(view_name: "all_galleries")
        visit new_gallery_path
        
        click_button 'Create Gallery'

        # Should allow the user in
        expect(page).to have_content('1 error prohibited this gallery from being saved:')
    end

    scenario 'creates a gallery' do
        test_login

        visit galleries_path(view_name: "all_galleries")
        visit new_gallery_path
        
        fill_in 'gallery', with: 'Test gallery'
        click_button 'Create Gallery'

        # Should create a gallery
        expect(page).to have_content('Test gallery')
    end

    scenario 'enters other\'s gallery' do
        test_other_gallery

        visit galleries_path(view_name: "all_galleries")
        visit '/galleries/1?view_name=all_galleries'
        
        # Should not allow user to delete gallery
        expect(page).not_to have_content('Delete Gallery')
    end

    scenario 'delete a gallery' do
        test_gallery

        visit galleries_path(view_name: "all_galleries")
        visit '/galleries/1?view_name=all_galleries'
        click_on('Delete Gallery')
        
        # Should allow user to delete gallery
        expect(page).to have_content('There are no galleries')
    end

    scenario 'edit a gallery' do
        test_gallery

        visit galleries_path(view_name: "all_galleries")
        visit '/galleries/1?view_name=all_galleries'
        click_on('Edit Title')

        fill_in 'gallery', with: 'New Title'
        click_button 'Update Gallery'
        
        # Should allow user to delete gallery
        expect(page).to have_content('New Title')
    end

    scenario 'enter my galleries' do
        test_other_gallery

        visit galleries_path(view_name: "all_galleries")
        visit '/galleries?view_name=my_galleries'
        
        # Shouldn't display any galleries
        expect(page).to have_content('There are no galleries')
    end
end