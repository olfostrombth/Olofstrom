class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @activities = PublicActivity::Activity.order("created_at desc")
    if current_user
      @categories = Category.all
      @colors = ["#56adba", "#7ab292", "#fba61f", "#ec529a"]
      @images = ["blur.png", "blurpink.png", "blurorange.png", "blurgreen.png"]
    else
      redirect_to login_url
    end
  end

  # GET /:category_name
  # GET /hej lOl xD
  # GET /hej%20lOl%20xD
  # GET /hej-lol-xd
  # GET /categories/1.json
  def show
    @category = Category.where(name: Category.normalize_cat(params[:category_name]))
    @category.each do |x|
      @comments = x.comments
      @comment = @comments.new
      @steps = x.steps
      @step = @steps.new
      @category = x
      @examinations = @category.examinations
      @examination = @examinations.new
      gon.catname = x.name
    end

    #cat = @category.to_json
    #cat = JSON.parse cat
    #puts "HEJ:::::: "+cat.to_json
    #@comments = cat.id

  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @category = Category.where(name: Category.normalize_cat(params[:category_name]))
    @category.each do |x|
      @category = x
    end
  end

  # POST /categories
  # POST /categories.json
  def create
    @owner = User.find(current_user.id)
    @category = Category.new({name:Category.normalize_cat(category_params[:name]), desc:category_params[:desc]})
    respond_to do |format|
      if @category.save
        @category.create_activity :create, owner: @owner, key: "har skapat en modul: #{view_context.link_to(@category.name, category_path(@category.name))}".html_safe
        format.html { redirect_to category_path(@category.name), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      @category.each do |x|
        @comments = x.comments
        @category = x
      end

      if @category.update({name:Category.normalize_cat(category_params[:name]), desc:category_params[:desc]})
        format.html { redirect_to category_path(@category.name), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.where(name: Category.normalize_cat(params[:category_name]))
    @category.each do |x|
      x.destroy
    end
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.where(name: Category.normalize_cat(params[:category_name]))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :desc)
    end
end
