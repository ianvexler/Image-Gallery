class ApplicationController < ActionController::Base
    helper_method :get_user_by_id, :get_images_by_gallery_id, :get_galleries_by_user_id

    def get_user_by_id(user_id)
        user = User.find(user_id)
        return user
    end

    def get_images_by_gallery_id(gallery_id)
        images = Image.where(gallery_id: gallery_id).all
        return images
    end

    def get_galleries_by_user_id
        galleries = Gallery.where(user_id: session[:user_id]).all
        return galleries
    end
end
