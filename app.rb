require 'httpclient'
require 'sinatra'
require 'redcarpet'

get '/' do
  erb :index
end

get '/EsperaSetup.exe' do
  redirect 'http://download.getespera.com/EsperaSetup.exe'
end

get '/EsperaPortable.zip' do
  redirect 'http://download.getespera.com/EsperaPortable.zip'
end

get '/Changelog.md' do
  redirect 'http://download.getespera.com/Changelog.md'
end

get '/releases/clickonce/:name' do
  redirect 'http://download.getespera.com/releases/clickonce/' + params[:name]
end

get '/release-notes' do
  erb :releasenotes
end

get '/about' do
  erb :about
end
