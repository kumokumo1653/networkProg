require 'sinatra'
require './cal'
require 'date'

set :environment, :production

$calendar = Cal.new(0,0)
get '/:year/:month' do
    date = Date.today
    @y = params[:year]
    @m = params[:month]
    if date.year == @y.to_i
        if date.month == @m.to_i
            @nowFlag = true
        else 
            @nowFlag = false
        end
    else 
        @nowFlag = false
    end
    if @nowFlag 
        @d = date.day
    else
        @d = 0
    end
    $calendar.setYear(@y.to_i)
    $calendar.setMonth(@m.to_i)
    @cal = $calendar.createCal
    @info = $calendar.createInfo(@cal,@d)
    pp @info
    erb :calmonth
end

get'/:year' do
    date = Date.today
    @y = params[:year]
    @nowFlag = false
    $calendar.setYear(@y.to_i)
    @cal = $calendar.createCalYear
    if(@y.to_i == date.year)
        @yearFalg = true
    else 
        @yearFalg = false
    end
        
    @m = date.month
    @d = date.day
    erb :calyear
end

