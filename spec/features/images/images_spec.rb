require 'rails_helper'

RSpec.describe 'create gallery', type: :system do
    scenario 'empty image upload' do
        user = User.create(email: 'email', username: 'username', password: 'password', password_confirmation: 'password')
        gallery = Gallery.create(title: 'Test gallery', user_id: user.id)

        visit login_path
        fill_in 'email', with: 'email'
        fill_in 'password', with: 'password'
        click_button 'Login'

        visit galleries_path(view_name: "all_galleries")        

        visit new_image_path(gallery_id: gallery.id)
        click_button 'Create Image'

        # Should show error
        expect(page).to have_content('1 error prohibited this user from being saved:')
    end

    scenario 'creates an image' do
        user = User.create(email: 'email', username: 'username', password: 'password', password_confirmation: 'password')
        gallery = Gallery.create(title: 'Test gallery', user_id: user.id)

        visit login_path
        fill_in 'email', with: 'email'
        fill_in 'password', with: 'password'
        click_button 'Login'

        visit galleries_path(view_name: "all_galleries")        

        visit new_image_path(gallery_id: gallery.id)
        attach_file('Image', './spec/features/images/test_image.webp')
        click_button 'Create Image'

        visit galleries_path(view_name: "all_galleries")    

        # Should allow image creation
        expect(page).to have_content('Test gallery')
    end

    scenario 'incorrect file type upload' do
        user = User.create(email: 'email', username: 'username', password: 'password', password_confirmation: 'password')
        gallery = Gallery.create(title: 'Test gallery', user_id: user.id)

        visit login_path
        fill_in 'email', with: 'email'
        fill_in 'password', with: 'password'
        click_button 'Login'

        visit galleries_path(view_name: "all_galleries")        

        visit new_image_path(gallery_id: gallery.id)
        attach_file('Image', './spec/features/images/test_pdf.pdf')
        click_button 'Create Image'

        # Should show type error
        expect(page).to have_content('Image type must be one of: image/jpeg, image/png, image/webp')
    end
end