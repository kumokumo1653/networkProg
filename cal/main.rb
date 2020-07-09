require 'sinatra'
require './cal'
require 'date'

set :environment, :production

$calendar = Cal.new(0,0)
get '/' do
    date = Date.today
    @y = date.year
    @m = date.month
    @d = date.day
    $calendar.setYear(@y)
    $calendar.setMonth(@m)
    @cal = $calendar.createCal
    @info,@title = $calendar.createInfo(@cal,@d)
    erb :calmonth
end

get '/:year/:month' do
    date = Date.today
    @y = params[:year]
    @m = params[:month]
    if @y.to_i < 1 || (@m.to_i < 1 && @m.to_i > 12) 
        erb :error
    else
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
        @info,@title = $calendar.createInfo(@cal,@d)
        erb :calmonth
    end
end

get'/:year' do
    date = Date.today
    @y = params[:year]
    if(@y.to_i < 1)
        erb :error
    else
        @nowFlag = false
        $calendar.setYear(@y.to_i)
        @cal = $calendar.createCalYear
        if(@y.to_i == date.year)
            @info,@title = $calendar.createInfoYear(@cal,date.month,date.day)
        else 
            @info,@title = $calendar.createInfoYear(@cal,0,0)
        end
        erb :calyear
    end
end

