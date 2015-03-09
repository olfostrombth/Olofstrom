class GuidesController < ApplicationController
  before_action :set_guide, only: [:show, :edit, :update, :destroy]

  # GET /guides
  # GET /guides.json
  def index
    @guides = Guide.all
  end

  # GET /guides/1
  # GET /guides/1.json
  def show
  end

  # GET /guides/new
  def new
    @guide = Guide.new
  end

  # GET /guides/1/edit
  def edit
    @guide = Guide.where(name: params[:guide_name])
    @guide.each do |x|
      @guide = x
    end
  end

  # POST /guides
  # POST /guides.json
  def create
    @guide = Guide.new({name: guide_params[:name], step_id: guide_params[:step_id], desc: guide_params[:desc]})
    @guide.save
    @stepx = Step.find(guide_params[:step_id])
    @guidex = Guide.where(name:guide_params[:name])
    @cat = Category.find(@stepx.category_id)

    @guidex.each do |x|
      @guidex = x
    end
    @substepx = Substep.new({
      typex: guide_params[:typex],
      sid: @guidex.id,
      Step_id: @stepx.id
      })

    respond_to do |format|
      if @substepx.save
        @substepx.update({row_order_position:guide_params[:row_order_position]})
        format.html { redirect_to step_path(@cat.name, @stepx.name), notice: 'Guide was successfully created.' }
        format.json { render :show, status: :created, location: @guide }
      else
        format.html { render :new }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guides/1
  # PATCH/PUT /guides/1.json
  def update
    step = Step.find(guide_params[:step_id])
    cat = Category.find(step.category_id)
    respond_to do |format|
      if @guide.update({name:guide_params[:name], desc:guide_params[:desc]})
        format.html { redirect_to step_path(cat.name, step.name), notice: 'Guide was successfully updated.' }
        format.json { render :show, status: :ok, location: @guide }
      else
        format.html { render :edit }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guides/1
  # DELETE /guides/1.json
  def destroy
    step = Step.find(@guide.step_id)
    cat = Category.find(step.category_id)
    @substep = Substep.where(sid: @guide.id)
    @substep.each do |x|
      @substep = x
    end
    @guide.destroy
    @substep.destroy
    respond_to do |format|
      format.html { redirect_to step_path(cat.name, step.name), notice: 'Guide was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guide
      @guide = Guide.where(name: params[:guide_name])
      @guide.each do |x|
        @guide = x
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guide_params
      params.require(:guide).permit(:name, :desc, :step_id, :typex, :row_order_position, :guide_name)
    end
end
