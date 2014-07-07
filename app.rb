require "sinatra"
require "rack-flash"

require "./lib/user_database"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @user_database = UserDatabase.new
  end

  get "/" do
    if current_user
      erb :signed_in, locals: {username: current_user[:username]}
    else
      erb :index
    end
  end

  get "/registration/new" do
    erb :"/registration/new"
  end

  post "/registration" do
    @user_database.insert(username: params[:username], password: params[:password])
    flash[:notice] = "Thanks for registering"
    redirect "/"
  end

  post "/session" do
    user = find_user(params)
    session[:user_id] = user[:id] if user
    redirect "/"
  end

  get "/logout" do
    session.delete(:user_id)
    flash[:notice] = "You are now signed out"
    redirect "/"
  end


  private

  def find_user(params)
    @user_database.all.select { |user| user[:username] == params[:username] && user[:password] == params[:password] }.first
  end

  def current_user
    if session[:user_id]
      @user_database.find(session[:user_id])
    end
  end
end
