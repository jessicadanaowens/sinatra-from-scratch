require "sinatra"
require "rack-flash"
require "active_record"
require "gschool_database_connection"


class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get '/' do
    "hello"
    erb :homepage, :locals=>{:member_info=>members}
  end

  post '/signup' do
    @database_connection.sql("INSERT INTO users (name, email) VALUES ('#{params[:name]}', '#{params[:email]}')")
    flash[:notice] = "You Rock!!!"
  redirect '/'
  end

  private

  def members
    @database_connection.sql("SELECT name from users")
  end



end