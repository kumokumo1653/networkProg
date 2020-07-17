require 'active_record'
require 'sinatra'

set :environment, :production
ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection :development

class Student < ActiveRecord::Base
end

get '/' do
    @s = Student.all
    erb :index
end

post '/new' do
    s = Student.new
    s.id = params[:id]
    s.name = params[:name]
    s.phonenum = params[:tel]
    s.save
    redirect '/'
end

delete '/del' do
    s = Student.find(params[:id])
    s.destroy
    redirect '/'
end
