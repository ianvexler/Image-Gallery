class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show update destroy ]
  before_action :set_gallery_id, only: %i[ new update ]

  # GET /images or /images.json
  def index
    @images = Image.all
  end

  # GET /images/1 or /images/1.json
  def show
   @gallery = get_gallery_by_image_id(@image.gallery_id)

   @view_name = params[:view_name]
  end

  # GET /images/new
  def new
    if session[:user_id].nil?
      redirect_to login_url
    else
      begin
        @gallery = Gallery.find(@gallery_id)
      rescue ActiveRecord::RecordNotFound
        redirect_to error_path
      end
      
      @image = Image.new
    end
  end

  # GET /images/1/edit
  def edit
    if session[:user_id].nil?
      redirect_to login_url
    end
    set_image

    @gallery = get_gallery_by_image_id(@image.gallery_id)
    @gallery_id = @gallery.user_id
  end

  # POST /images or /images.json
  def create
    @image = Image.new(image_params)
    @gallery_id = @image.gallery_id

    respond_to do |format|
      if @image.save
        format.html { redirect_to image_url(@image), notice: "Image was successfully created." }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_entity}
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    @gallery_id = @image.gallery_id

    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to image_url(@image), notice: "Image was successfully updated." }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy

    respond_to do |format|
      format.html { redirect_to gallery_path(@image.gallery_id, view_name: "my_galleries"), notice: "Image was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      begin
        @image = Image.find_by_id(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to error_path
      end
    end

    # Sets the gallery_id according to the given parameters
    def set_gallery_id
      @gallery_id = params[:gallery_id]
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:image, :gallery_id)
    end
end
