class MainController < ApplicationController
    def index
        @recent_galleries = Gallery.order(created_at: :desc)
    end
end
