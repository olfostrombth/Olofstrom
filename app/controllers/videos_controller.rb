class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
    @video = Video.where(name: params[:video_name])
    @video.each do |x|
      @video = x
    end
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new({name: video_params[:name], step_id: video_params[:step_id], url: video_params[:url]})
    @video.save
    # cat = Category.find(step_params[:category_id])
    step = Step.find(video_params[:step_id])
    cat = Category.find(step.category_id)
    @videox = Video.where(name:video_params[:name])
    @videox.each do |x|
      @videox = x
    end
    @substep = Substep.new({
      typex: video_params[:typex],
      sid: @videox.id,
      Step_id: step.id
      })

    respond_to do |format|
      if @substep.save
        @substep.update({row_order_position:video_params[:row_order_position]})
        format.html { redirect_to step_path(cat.name, step.name), notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }

      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    step = Step.find(video_params[:step_id])
    cat = Category.find(step.category_id)
    respond_to do |format|
      if @video.update({name:video_params[:name], url:video_params[:url]})
        format.html { redirect_to step_path(cat.name, step.name), notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    step = Step.find(@video.step_id)
    cat = Category.find(step.category_id)
    @substep = Substep.where(sid: @video.id)
    @substep.each do |x|
      @substep = x
    end
    @video.destroy
    @substep.destroy
    respond_to do |format|
      format.html { redirect_to step_path(cat.name, step.name), notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_video
      @video = Video.where(name: params[:video_name])
      @video.each do |x|
        @video = x
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:name, :url, :step_id, :typex, :row_order_position, :video_name)
    end
end
