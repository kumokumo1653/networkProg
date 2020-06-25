require 'sinatra'
require './cal'
require 'date'

set :environment, :production

date = Date.today

get '/:year/:month' do
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
    end
    @ca = Cal.new(@y.to_i,@m.to_i)
    @cal = @ca.createCal
    erb :calmonth
end

get'/:year' do
    @y = params[:year]
    @nowFlag = false
    ca = Cal.new(@y.to_i)
    @cal = ca.createCalYear
    @m = date.month
    @d = date.day
    erb :calyear
end

