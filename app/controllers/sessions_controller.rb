class SessionsController < ApplicationController
  require 'cgi'


  #Create Session and set User in DB
  def index
    @sessions = User.paginate(page: params[:page])
  end

  def search
    if params[:query].present?
      @usersearch = User.search(params[:query],
                                fields: [:name],
                                page: params[:page])
    else
      @usersearch = User.all.page params[:page]
    end

    if @usersearch.length == 1
      @results = @usersearch.results
      @results.each do |x|
        @user_name = x.name
      end
      @user_name.split("-")
      @user = User.find(@usersearch.first.id)
      redirect_to user_path(@user.name.split(" ")[0]+'-'+@user.id.to_s)
      return
    end
  end

  def autocomplete
    render json: User.search(params[:query], autocomplete: false, limit: 10).map(&:name)
  end

  def show
    @split = params[:name_url].split("-")
    @user = User.find(@split[1])
    @usersearch = @user
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: @user)
    gon.completion = @user.completion
    @completion = Hash[JSON.parse(gon.completion).to_a.reverse]
    #@comments = @user.comments     .last(2)
    #@comments.each do |x|
    #  @category = Category.find(x.category_id)
    #end

  end

  def delUser
    respond_to do |format|
      @user = User.find(params[:id])
      if @user.destroy
        format.html {redirect_to root_path, notice: "Deleted account"}
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
    @user = User.new

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

end