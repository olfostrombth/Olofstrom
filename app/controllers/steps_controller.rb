class StepsController < ApplicationController
  before_action :set_step, only: [:show, :edit, :update, :destroy, :substep_params, :completion_params]

  # GET /steps
  # GET /steps.json
  def index
    @steps = Step.all
    puts "hej"
  end

  def update_row_order
    @substepx = Substep.find(substep_params[:substep_id])
    if @substepx.update({row_order_position:substep_params[:row_order_position]})
      render nothing: true
    end
  end

  #Update the completion string in Database
  def update_completion
    #Get
    substeps = completion_params[:substepsx]
    category_name = completion_params[:name].to_s
    step_name = completion_params[:step_name].to_s
    if current_user
      updater = User.find(current_user.id)
      completion = {}
      completion = JSON.parse(updater.completion)
      completion[category_name.to_sym] = {}
      completion[category_name.to_sym][step_name.to_sym] = substeps
      completion[category_name.to_sym][step_name.to_sym]["examination"] = {}
      completion[category_name.to_sym][step_name.to_sym]["examination"]["done"] = false
      completion[category_name.to_sym][step_name.to_sym]["examination"]["corrected"] = false
      puts substeps
      if updater.update({completion:completion.to_json})
        render nothing:true
        puts "Updated completion, plx"
      end
    end

  end

  #GET /:modulename/:stepname
  def show
    puts "ASDASDASDASD"
    gon.stepname = Category.normalize_cat(params[:step_name])
    gon.catname = Category.normalize_cat(params[:category_name])
    gon.completion = current_user.completion if current_user

    unless current_user.completion[gon.catname]
      user = User.find(current_user.id)
      comp = JSON.parse(user.completion)
      comp[gon.catname] = {}
      comp[gon.catname][gon.stepname] = {}
      user.update({completion: comp.to_json})
    end

    @catname = params[:category_name]
    @step_items = []
    @step = Step.where(name:Category.normalize_cat(params[:step_name]))
        @step.each do |x|
          @step = x
        end
    @substep = Substep.rank(:row_order).where(step_id: @step.id)
    puts "HHHHHHHHEEELLOOOO"
    puts "SUBSTEP: " + @substep.to_s
    @substep.each do |x|
      if x.typex == "video"
        video = Video.find(x.sid)
        videox = video.attributes
        videox['uid'] = x.id
        @step_items.push(videox)
      elsif x.typex == "guide"
        guide = Guide.find(x.sid)
        guidex = guide.attributes
        guidex['uid'] = x.id
        @step_items.push(guidex)
      elsif x.typex == "assignment"
        assignment = Assignment.find(x.sid)
        assignmentx = assignment.attributes
        assignmentx['uid'] = x.id
        @step_items.push(assignmentx)
      elsif x.typex == "quiz"
        quix = Quiz.find(x.sid)
        quizx = quix.attributes
        quizx['uid'] = x.id
        quizx['quiz_type'] = 'quiz_tx'
        @step_items.push(quizx)
      end
    end
    @stepx = Step.where(name:Category.normalize_cat(params[:step_name]))
    #@step_items = []
    @stepx.each do |x|
      @steps = x
      @videos = @steps.videos
      @videos.each do |videos|
        #@step_items.push(videos)
      end
      @video = @videos.new

      @guides = @steps.guides
      @guides.each do |guides|
        #@step_items.push(guides)
      end
      @guide = @guides.new
      @assignments = @steps.assignments
      @assignments.each do |assignments|
        #@step_items.push(assignments)
      end
      @assignment = @assignments.new
      @quizzes = @steps.quizzes
      @quizzes.each do |q|
        @quiz_id = q.id
        @questions = q.questions
        #@step_items.push(q)
      end
      @quiz = @quizzes.new
      if @questions
        @question = @questions.new
      end
    end
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
    @owner = User.find(current_user.id)
    @step = Step.new({name:Category.normalize_cat(step_params[:name]), desc:step_params[:desc], category_id:step_params[:category_id]})
    cat = Category.find(step_params[:category_id])
    #category = @step.category.name


    respond_to do |format|
      if @step.save
        @step.create_activity :create, owner: @owner, key: "har skapat ett steg: #{view_context.link_to(@step.name, step_path(cat.name, @step.name))}".html_safe
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
      format.html { redirect_to root_url, notice: 'Step was successfully destroyed.' }
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


    def substep_params
      params.require(:substep).permit(:substep_id, :row_order_position, :name, :step_name, :substepsx)
    end

    def completion_params
      params.require(:step).permit!
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(:name, :desc, :category_id, :type, :substepsx, :step_name)
    end

end
