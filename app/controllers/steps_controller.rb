class StepsController < ApplicationController
  before_action :set_step, only: [:show, :edit, :update, :destroy]

  # GET /steps
  # GET /steps.json
  def index
    @steps = Step.all
  end

  # GET /steps/1
  # GET /steps/1.json
  def show
    @step = Step.find(params[:id])
    @videos = @step.videos
    @quizzes = @step.quizzes
    @quizzes.each do |q|
      @quiz = q.id
      @questions = q.questions
    end
    @question = Question.new #ta bort detta snusk, fulfix för att kunna se radiobuttons etc i show för steps.
  end

  def grade_quiz
    @step = Step.find(params[:id])
    gon.quizzes = @step.quizzes
    @answers = []
    @quizzes.each do |q|
      @quiz = q.id
      @questions = @quiz.questions
      @questions.each do |q|
        @answer = params[:answer]
        if @answer == q.answer
          @answers.push('true')
        else
          @answers.push('false')
        end
       #Exempel: @answers = ['true', 'true', 'false', 'true']
      end
      #Iterera igenom arrayen, om alla är "korrekt", grattis
      #Annars hittas de med "error" och den relaterade frågan highlightas för användaren
    end
  end

  # GET /steps/new
  def new
    @step = Step.new
  end

  # GET /steps/1/edit
  def edit
  end

  # POST /steps
  # POST /steps.json
  def create
    @step = Step.new(step_params)

    respond_to do |format|
      if @step.save
        format.html { redirect_to @step, notice: 'Step was successfully created.' }
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
      if @step.update(step_params)
        format.html { redirect_to @step, notice: 'Step was successfully updated.' }
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
      @step = Step.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(:name, :desc, :category_id)
    end
end
