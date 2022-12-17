class SearchController < ApplicationController
    def index
        @query = Gallery.ransack(params[:q])
        @galleries = @query.result(distinct: true)
    end
end