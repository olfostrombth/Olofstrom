class SessionsController < ApplicationController
  require 'gitkit_client'
  require 'cgi'

  helper_method :sortable
  helper_method :sort_column, :sort_direction
  #Create Session and set User in DB
  def index
    if params[:search]
      @users = User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    else
      @users = User.paginate(:page => params[:page], :per_page => 50)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
    end
  end

  def show
    @user = User.find(params[:id])

    gon.completion = @user.completion
  end

  def delUser
    respond_to do |format|
      @user = User.find(params[:id])
      if @user.destroy
        format.html {redirect_to root_path, notice: "Delteed account"}
      else
        format.html {redirect_to root_path, notice: "Failed delete"}
      end
    end
  end

  def update
    respond_to do |format|
      @user = User.find(params[:id])
      if @user.update(session_params)
        format.html {redirect_to root_path, notice: "Success update!!"}
      else
        format.html {redirect_to root_path, notice: "Failed update"}
      end
    end
  end
  #Admin page
  def admin
    if current_user
      if current_user.admin?
        #do stuff
        @sessions = User.paginate(page: params[:page])

        gon.completion = @current_user.completion
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  #POST
  def importUsers
      User.import(params[:file])
      redirect_to root_url, notice: "Användare importerade!"
  end

  def create
    finduser = User.where(email: env["omniauth.auth"]["info"]["email"])
    #if(finduser.empty?)
    #  redirect_to login_url
    #else
      user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      token = request.cookies["gtoken"]
      @postBody = CGI.escape(request.body.read)
      redirect_to root_path
    #end
  end
  #Login viewssions/show/1
  def login
    #gitkit_client = GitkitLib::GitkitClient.create_from_config_file url('assets/gitkit-server-config.json')
    token = request.cookies["gtoken"]
    @postBody = request.original_url
    puts request.env
  end
  #Destroys session (logout)
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def session_params
      params.require(:user).permit(:admin)
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    
end
