require 'active_record'

ActiveRecord::Base.configurations = YAML.load_file('datebase.yml')
ActiveRecord::Base.establish_connection :development

class Eventday < ActiveRecord::Base
    self.table_name = 'eventdays'
end

a = Eventday.find(1)

puts a.name

