class SlideritemsController < ApplicationController
  before_action :set_slideritem, only: [:show, :edit, :update, :destroy]

  # GET /slideritems
  # GET /slideritems.json
  def index
    @slideritems = Slideritem.all
    @slideritem = Slideritem.new
  end

  # GET /slideritems/1
  # GET /slideritems/1.json
  def show
  end

  # GET /slideritems/new
  def new
    @slideritem = Slideritem.new
  end

  # GET /slideritems/1/edit
  def edit

  end

  # POST /slideritems
  # POST /slideritems.json
  def create
    @slideritem = Slideritem.new(slideritem_params)

    respond_to do |format|
      if @slideritem.save
        format.html { redirect_to @slideritem, notice: 'Slideritem was successfully created.' }
        format.json { render :show, status: :created, location: @slideritem }
      else
        format.html { render :new }
        format.json { render json: @slideritem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slideritems/1
  # PATCH/PUT /slideritems/1.json
  def update
    respond_to do |format|
      if @slideritem.update(slideritem_params)
        format.html { redirect_to @slideritem, notice: 'Slideritem was successfully updated.' }
        format.json { render :show, status: :ok, location: @slideritem }
      else
        format.html { render :edit }
        format.json { render json: @slideritem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slideritems/1
  # DELETE /slideritems/1.json
  def destroy
    @slideritem.destroy
    respond_to do |format|
      format.html { redirect_to slideritems_url, notice: 'Slideritem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slideritem
      @slideritem = Slideritem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slideritem_params
      params.require(:slideritem).permit(:rubrik, :text)
    end
end
