class UserExaminationsController < ApplicationController
  before_action :set_user_examination, only: [:show, :edit, :update, :destroy]

  # GET /user_examinations
  # GET /user_examinations.json
  def index
    @user_examinations = UserExamination.all
  end

  # GET /user_examinations/1
  # GET /user_examinations/1.json
  def show
  end

  # GET /user_examinations/new
  def new
    @user_examination = UserExamination.new
  end

  # GET /user_examinations/1/edit
  def edit
  end

  # POST /user_examinations
  # POST /user_examinations.json
  def create
    @user_examination = UserExamination.new(user_examination_params)

    respond_to do |format|
      if @user_examination.save
        format.html { redirect_to @user_examination, notice: 'User examination was successfully created.' }
        format.json { render :show, status: :created, location: @user_examination }
      else
        format.html { render :new }
        format.json { render json: @user_examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_examinations/1
  # PATCH/PUT /user_examinations/1.json
  def update
    respond_to do |format|
      if @user_examination.update(user_examination_params)
        format.html { redirect_to @user_examination, notice: 'User examination was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_examination }
      else
        format.html { render :edit }
        format.json { render json: @user_examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_examinations/1
  # DELETE /user_examinations/1.json
  def destroy
    @user_examination.destroy
    respond_to do |format|
      format.html { redirect_to user_examinations_url, notice: 'User examination was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_examination
      @user_examination = UserExamination.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_examination_params
      params.require(:user_examination).permit(:examination_id, :user_id, :msg, :corrected)
    end
end
