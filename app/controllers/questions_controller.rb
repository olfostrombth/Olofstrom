class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @questions = Question.all
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @question = Question.where(question: params[:question_name])
    @question.each do |x|
      @question = x
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @quiz = @question.quiz_id
    @quizx = Quiz.find(@quiz)
    @stepx = Step.find(@quizx.step_id)
    @cat = Category.find(@stepx.category_id)

    respond_to do |format|
      if @question.save
        format.html { redirect_to step_path(@cat.name, @stepx.name), notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @quiz = Quiz.find(question_params[:quiz_id])
    respond_to do |format|
      if @question.update({question:question_params[:question], option1:question_params[:option1], option2:question_params[:option2], answer:question_params[:answer], quiz_id:question_params[:quiz_id]})
        format.html { redirect_to edit_quiz_path(@quiz.name), notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @quiz = Quiz.find(@question.quiz_id)
    @question.destroy
    respond_to do |format|
      format.html { redirect_to edit_quiz_path(@quiz.name), notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.where(question: params[:question_name])
      @question.each do |x|
        @question = x
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :option1, :option2, :option3, :answer, :quiz_id, :question_name)
    end
end
