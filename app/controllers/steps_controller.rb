class StepsController < ApplicationController
  before_action :set_step, only: [:show, :edit, :update, :destroy]

  # GET /steps
  # GET /steps.json
  def index
    @steps = Step.all
  end

  #GET /:modulename/:stepname
  def show
    @catname = params[:category_name]
    @step = Step.where(name:Category.normalize_cat(params[:step_name]))
    @step.each do |x|
      @step = x
      @videos = @step.videos
      @video = @videos.new
      @quizzes = @step.quizzes
      @guides = @step.guides
      @guide = @guides.new
      @quizzes.each do |q|
        @quiz_id = q.id
        @questions = q.questions
      end
      @quiz = @quizzes.new
    end
    @question = Question.new
  end

  # GET /steps/new
  def new
    @step = Step.new
  end

  # GET /steps/1/edit
  def edit
    @step = Step.where(name:Category.normalize_cat(params[:step_name]))
    @step.each do |x|
      @step = x
    end
  end

  # POST /steps
  # POST /steps.json
  def create
    @step = Step.new({name:Category.normalize_cat(step_params[:name]), desc:step_params[:desc], category_id:step_params[:category_id]})
    cat = Category.find(step_params[:category_id])
    #category = @step.category.name


    respond_to do |format|
      if @step.save
        format.html { redirect_to step_path(cat.name, @step.name), notice: 'Step was successfully created.' }
       # format.html { redirect_to category_path(category), notice: 'Step was successfully created'}
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steps/1
  # PATCH/PUT /steps/1.json
  def update
    respond_to do |format|

      if @step.update({name:Category.normalize_cat(step_params[:name]), desc:step_params[:desc]})
        format.html { redirect_to step_path(params[:category_name],@step.name), notice: 'Step was successfully updated.' }
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1
  # DELETE /steps/1.json
  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to steps_url, notice: 'Step was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_step
      @step = Step.where(name:Category.normalize_cat(params[:step_name]))
      @step.each do |x|
        @step = x
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(:name, :desc, :category_id)
    end

end
