include ERB::Util

class ApplicationController < ActionController::Base
    helper_method :get_user_by_id, :get_images_by_gallery_id, :get_galleries_by_user_id
    before_action :set_query

    def set_query
        @query = Gallery.ransack(params[:q])
    end 

    # Returns a user given its id
    def get_user_by_id(user_id)
        begin
            user = User.find(user_id)
            return user
        rescue ActiveRecord::RecordNotFound
            redirect_to error_path
        end
    end

    # Returns all images in a gallery given its id
    def get_images_by_gallery_id(gallery_id)
        images = Image.where(gallery_id: gallery_id).all
        return images
    end

    # Returns all galleries given a user id
    def get_galleries_by_user_id
        galleries = Gallery.where(user_id: session[:user_id]).all
        return galleries
    end

    # Returns a gallery given an id
    def get_gallery_by_image_id(gallery_id)
        begin
            gallery = Gallery.find(gallery_id)
            return gallery
        rescue ActiveRecord::RecordNotFound
            redirect_to error_path
        end
    end
end
