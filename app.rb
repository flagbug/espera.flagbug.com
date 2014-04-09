require 'httpclient'
require 'sinatra'
require 'redcarpet'

get '/' do
  erb :index
end

get '/EsperaSetup.exe' do
  redirect 'http://espera.s3.amazonaws.com/EsperaSetup.exe'
end

get '/EsperaPortable.zip' do
  redirect 'http://espera.s3.amazonaws.com/EsperaPortable.zip'
end

get '/EsperaBetaSetup.exe' do
  redirect 'http://espera.s3.amazonaws.com/EsperaBetaSetup.exe'
end

get '/release-notes' do
  client = HTTPClient.new
  content = client.get_content("https://s3.amazonaws.com/espera/Changelog.md")
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  @rendered = markdown.render(content)
  
  erb :releasenotes
end

get '/about' do
  erb :about
end
