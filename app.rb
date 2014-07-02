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
    erb :index, :locals => {:users => @users}
  end

  get "/register" do
    erb :register
  end

  post "/register" do
    username = params[:username]
    password = params[:password]
    @users.insert(@user, :username => username, :password => password)
    redirect "/"
  end
end
