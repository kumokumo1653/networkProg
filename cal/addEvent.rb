require 'active_record'
require './cal'

ActiveRecord::Base.configurations = YAML.load_file('./database/database.yml')

class Eventbase < ActiveRecord::Base
    ActiveRecord::Base.establish_connection :eventdays
    self.abstract_class = true
end

class Eventday < Eventbase
    self.table_name = 'eventdays'
end

class Decideweek < Eventbase
    self.table_name = 'decideweeks'
end

class Event < Eventbase
    self.table_name = 'events'
end

class EventUpdater
    def initialize(y)
        @y = y
    end

    def setYear(y)
        @y = y
    end

    def update
        @day = Eventday.all
        @week = Decideweek.all
        calendar = Cal.new(@y)
        cal = calendar.createCalYear 
        cnt = 1
        event = Event.all
        event.each do |a|
            a.destroy
        end
        @day.each do |a|
            if(a.startyear <= @y && (a.endyear >= @y || a.endyear == -1))
                e = Event.new
                e.id = cnt
                e.name = a.name
                e.month = a.month
                e.day = a.day
                e.category = a.category
                e.save
                cnt = cnt + 1
            end
        end
        @week.each do |a|
            if(a.startyear <= @y && (a.endyear >= @y || a.endyear == -1))
                e = Event.new
                e.id = cnt
                e.name = a.name
                e.month = a.month
                calendar.setMonth(a.month)
                e.day = calendar.searchNumOfWeek(a.week,a.number)
                e.category = a.category
                e.save
                cnt = cnt + 1
            end
        end
        return Event.all
    end
        
                
end
    

