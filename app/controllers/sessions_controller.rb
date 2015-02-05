class SessionsController < ApplicationController
  require 'gitkit_client'
  require 'cgi'
  #Create Session and set User in DB
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    gitkit_client = GitkitLib::GitkitClient.create_from_config_file '/home/kevin/Projects/Olofstrom/app/assets/gitkit-server-config.json'
    token = request.cookies["gtoken"]
    @postBody = CGI.escape(request.body.read)
    gitkit_user,_ = gitkit_client.verify_gitkit_token token
    redirect_to root_path
  end
  #Login view
  def login
    #gitkit_client = GitkitLib::GitkitClient.create_from_config_file url('assets/gitkit-server-config.json')
    gitkit_client = GitkitLib::GitkitClient.create_from_config_file '/home/kevin/Projects/Olofstrom/app/assets/gitkit-server-config.json'
    token = request.cookies["gtoken"]
    gitkit_user,_ = gitkit_client.verify_gitkit_token token
    @postBody = request.original_url
    puts request.env
  end
  #Destroys session (logout)
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
