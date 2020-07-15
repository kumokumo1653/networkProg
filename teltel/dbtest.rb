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
