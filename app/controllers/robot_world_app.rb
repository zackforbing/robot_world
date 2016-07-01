require 'sqlite3'

class RobotWorldApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do
    erb :dashboard
  end

  get '/robots' do
    @robots = robot_world.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    robot_world.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id/edit' do |id|
    @robot = robot_world.find(id)
    erb :edit
  end

  put '/robots/:id' do |id|
    robot_world.update(id.to_i, params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |id|
    @robot = robot_world.find(id)
    erb :show
  end

  delete '/robots/:id' do |id|
    robot_world.destroy(id)
    redirect '/robots'
  end

  def robot_world
    if ENV['RACK_ENV'] == 'test'
    database = SQLite3::Database.new("db/robot_world_test.db")
  else
    database = SQLite3::Database.new("db/robot_world_development.db")
  end
  database.results_as_hash = true
  RobotWorld.new(database)
  end
end
