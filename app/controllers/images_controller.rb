class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show edit update destroy ]
  before_action :set_gallery_id, only: %i[ new ]

  # GET /images or /images.json
  def index
    @images = Image.all
  end

  # GET /images/1 or /images/1.json
  def show
    if session[:user_id].nil?
      redirect_to login_url
    end
  end

  # GET /images/new
  def new
    if session[:user_id].nil?
      redirect_to login_url
    else
      @gallery = Gallery.find(@gallery_id)
      @image = Image.new
    end
  end

  # GET /images/1/edit
  def edit
    if session[:user_id].nil?
      redirect_to login_url
    end
  end

  # POST /images or /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to image_url(@image), notice: "Image was successfully created." }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
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
      @image = Image.find(params[:id])
    end

    def set_gallery_id
      @gallery_id = params[:gallery_id]
      print("here")
      print(@gallery_id)
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:image, :gallery_id)
    end
end
