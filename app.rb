require "sinatra"
require "rack-flash"

require "./lib/user_database"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @user_database = UserDatabase.new
    @user = {}
  end

  helpers do
    def flash_types
      [:success, :notice, :warning, :error]
    end
  end


  get "/" do
    @user[:id] = session[:user_id]
    #user_database.find(id)
    erb :index, :locals => {username => user[:username]}
  end

  get "/register" do
    erb :register
  end

  post "/register" do
    username = params[:username]
    password = params[:password]
    user = @user_database.insert({:username => username, :password => password})
    session[:user_id] = user[:id]
    flash[:success] = 'Thank you for registering'
    redirect "/"
  end

  post "/" do
     @user.delete
     erb :index, :locals => {:user => @user}
  end
end
