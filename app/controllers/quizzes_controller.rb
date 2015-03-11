class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = Quiz.all
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
    @quiz = Quiz.find(params[:id])
    @questions = @quiz.questions
    @question = @questions.new
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
    @quiz = Quiz.where(name: params[:quiz_name])
    @quiz.each do |x|
      @quiz = x
    end
    @questions = @quiz.questions
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    @quiz = Quiz.new({name: quiz_params[:name], step_id: quiz_params[:step_id]})
    @quiz.save

    #Find step and category
    @stepx = Step.find(quiz_params[:step_id])
    @cat = Category.find(@stepx.category_id)
    #Find quiz
    @quizx = Quiz.where(name:quiz_params[:name])
    @quizx.each do |x|
      @quizx = x
    end
    #new substep
    @substepx = Substep.new({
      typex: quiz_params[:typex],
      sid: @quizx.id,
      Step_id: @stepx.id
      })

    respond_to do |format|
      if @substepx.save
        @substepx.update({row_order_position:quiz_params[:row_order_position]})
        format.html { redirect_to step_path(@cat.name, @stepx.name), notice: 'Quiz was successfully created.' }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  def update
    step = Step.find(quiz_params[:step_id])
    cat = Category.find(step.category_id)
    respond_to do |format|
      if @quiz.update(name:quiz_params[:name])
        format.html { redirect_to step_path(cat.name, step.name), notice: 'Quiz was successfully updated.' }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    step = Step.find(@quiz.step_id)
    cat = Category.find(step.category_id)
    @substep = Substep.where(sid: @quiz.id)
    @substep.each do |x|
      @substep = x
    end
    @quiz.destroy
    @substep.destroy
    respond_to do |format|
      format.html { redirect_to step_path(cat.name, step.name), notice: 'Quiz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.where(name: params[:quiz_name])
      @quiz.each do |x|
        @quiz = x
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:name, :step_id, :typex, :row_order_position, :quiz_name)
    end
end
