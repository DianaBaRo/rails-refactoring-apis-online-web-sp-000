class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    github = GithubService.new
    session[:token] = github.authenticate!(ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_SECRET'], params[:code])

    user_response = github.get_username
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to root_path
  end
end
