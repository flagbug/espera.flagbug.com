require 'httpclient'
require 'sinatra'
require 'redcarpet'

get '/' do
  erb :index
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