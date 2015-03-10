class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
    @categories = Category.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    if !current_user
      redirect_to login_url
    end
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.where(name: params[:assignment_name])
    @assignment.each do |x|
      @assignment = x
    end
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new({name: assignment_params[:name], step_id: assignment_params[:step_id], desc: assignment_params[:desc]})
    @assignment.save
    @stepx = Step.find(assignment_params[:step_id])
    @assignmentx = Assignment.where(name:assignment_params[:name])
    @cat = Category.find(@stepx.category_id)
    @assignmentx.each do |x|
      @assignmentx = x
    end
    @substep = Substep.new({
      typex: assignment_params[:typex],
      sid: @assignmentx.id,
      Step_id: @stepx.id
      })


    respond_to do |format|
      if @substep.save
        @substep.update({row_order_position:assignment_params[:row_order_position]})
        format.html { redirect_to step_path(@cat.name, @stepx.name), notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    step = Step.find(assignment_params[:step_id])
    cat = Category.find(step.category_id)
    respond_to do |format|
      if @assignment.update(name:assignment_params[:name], desc:assignment_params[:desc])
        format.html { redirect_to step_path(cat.name, step.name), notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    step = Step.find(@assignment.step_id)
    cat = Category.find(step.category_id)
    @substep = Substep.where(sid: @assignment.id)
    @substep.each do |x|
      @substep = x
    end
    @assignment.destroy
    @substep.destroy
    respond_to do |format|
      format.html { redirect_to step_path(cat.name, step.name), notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.where(name: params[:assignment_name])
      @assignment.each do |x|
        @assignment = x
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:name, :desc, :step_id, :typex, :row_order_position, :assignment_name)
    end
end
