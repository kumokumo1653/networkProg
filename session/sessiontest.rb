require 'sinatra'

set :sessions,
    secret: 'xxx'

set :environment, :production

get '/hoge' do 
    session[:message] = 'AAA'
    redirect '/fuga'
end

get '/fuga' do
    session[:message]
end
