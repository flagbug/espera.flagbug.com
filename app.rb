require 'httpclient'
require 'sinatra'
require 'json'
require 'redcarpet'
require 'newrelic_rpm'
require 'nokogiri'

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
  client = HTTPClient.new
  content = client.get_content("http://download.getespera.com/Changelog.md")
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  @rendered = markdown.render(content)
  
  erb :releasenotes
end

get '/about' do
  erb :about
end

get '/versions/current' do
  client = HTTPClient.new
  content = client.get_content("http://download.getespera.com/releases/clickonce/Espera.application")
  
  versionRegex = /assemblyIdentity name="Espera.application" version="(\d+.\d+.\d+.\d+)"/
  
  version = versionRegex.match(content).captures[0]
  
  content_type :json
  { :version => version }.to_json
end