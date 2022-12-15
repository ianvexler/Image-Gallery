class GalleriesController < ApplicationController
  before_action :set_gallery, only: %i[ show edit update destroy slideshow ]

  # GET /galleries or /galleries.json
  def index
    @galleries = Gallery.all
    if params[:view_name] == "all_galleries"
      render 'all_galleries'
    else
      if session[:user_id].nil?
        redirect_to login_url
      else
        render 'my_galleries'
      end
    end
  end

  # GET /galleries/1 or /galleries/1.json
  def show; end

  # GET /galleries/new
  def new
    if session[:user_id].nil?
      redirect_to login_url
    else
      @gallery = Gallery.new
    end
  end

  # GET /galleries/1/edit
  def edit
    if session[:user_id].nil?
      redirect_to login_url
    end
  end

  # POST /galleries or /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to gallery_url(@gallery), notice: "Gallery was successfully created." }
        format.json { render :show, status: :created, location: @gallery }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galleries/1 or /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to gallery_url(@gallery), notice: "Gallery was successfully updated." }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1 or /galleries/1.json
  def destroy
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to galleries_url, notice: "Gallery was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /slideshow
  def slideshow; end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    def check_params
      if params[:gallery][:title].empty?
        return false
      end
    end

    # Only allow a list of trusted parameters through.
    def gallery_params
      params.require(:gallery).permit(:title, :user_id)
    end
end
