require 'sinatra'

get '/' do
  erb :index
end

get '/release-notes' do
  erb :releasenotes
end