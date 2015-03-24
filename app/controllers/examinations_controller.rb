class ExaminationsController < ApplicationController
  before_action :set_examination, only: [:show, :edit, :update, :destroy]

  # GET /examinations
  # GET /examinations.json
  def index
    @examinations = Examination.all
    @categories = Category.all

  end

  # GET /examinations/1
  # GET /examinations/1.json
  def show
    @user_examination = UserExamination.new
    @examination = Examination.where(name: params[:examination_name])
    @examination.each do |x|
      @examination = x
    end
  end

  # GET /examinations/new
  def new
    @examination = Examination.new
  end

  # GET /examinations/1/edit
  def edit
    @examination = Examination.where(name: params[:examination_name])
    @examination.each do |x|
      @examination = x
    end
  end

  # POST /examinations
  # POST /examinations.json
  def create
    @examination = Examination.new(name: examination_params[:name], category_id: examination_params[:category_id], desc: examination_params[:desc])
    @category = @examination.category.name

    respond_to do |format|
      if @examination.save
        format.html { redirect_to category_path(@category), notice: 'Examination was successfully created.' }
        format.json { render :show, status: :created, location: @examination }
      else
        format.html { render :new }
        format.json { render json: @examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /examinations/1
  # PATCH/PUT /examinations/1.json
  def update
    cat = Category.find(examination_params[:category_id])
    respond_to do |format|
      if @examination.update({name:examination_params[:name], desc:examination_params[:desc]})
        format.html { redirect_to category_path(cat.name), notice: 'Examination was successfully updated.' }
        format.json { render :show, status: :ok, location: @examination }
      else
        format.html { render :edit }
        format.json { render json: @examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /examinations/1
  # DELETE /examinations/1.json
  def destroy
    cat = Category.find(@examination.category_id)
    @examination.destroy
    respond_to do |format|
      format.html { redirect_to category_path(cat.name), notice: 'Examination was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_examination
      @examination = Examination.where(name: params[:examination_name])
      @examination.each do |x|
        @examination = x
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def examination_params
      params.require(:examination).permit(:name, :desc, :category_id, :examination_name)
    end
end
