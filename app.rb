require 'httpclient'
require 'sinatra'
require 'redcarpet'

get '/' do
  erb :index
end

get '/EsperaSetup.exe' do
  redirect 'http://d1lzv0n76maidw.cloudfront.net//EsperaSetup.exe'
end

get '/EsperaPortable.zip' do
  redirect 'http://d1lzv0n76maidw.cloudfront.net/EsperaPortable.zip'
end

get '/Changelog.md' do
  redirect 'http://d1lzv0n76maidw.cloudfront.net/Changelog.md'
end

get '/releases/clickonce/:name' do
  redirect 'http://d1lzv0n76maidw.cloudfront.net/releases/clickonce/' + params[:name]
end

get '/release-notes' do
  client = HTTPClient.new
  content = client.get_content("http://d1lzv0n76maidw.cloudfront.net/Changelog.md")
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  @rendered = markdown.render(content)
  
  erb :releasenotes
end

get '/about' do
  erb :about
end
