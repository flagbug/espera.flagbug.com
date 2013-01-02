require 'httpclient'
require 'sinatra'

get '/' do
  erb :index
end

get '/release-notes' do
  @releases = ReleaseNotes::get_changelog
  erb :releasenotes
end

module ReleaseNotes
    def self.get_changelog
      client = HTTPClient.new
      changelog = client.get_content("http://raw.github.com/flagbug/Espera/master/Changelog.txt")
        
      version_header_match = /----------------------------------- v[0-9].[0-9].[0-9] -----------------------------------/
      version_match = /[0-9].[0-9].[0-9]/
      
      versions = changelog.scan(version_header_match).map{|header| header.scan(version_match)}
      version_contents = changelog.split(version_header_match).reject(&:empty?)

      changetypes = ["FEATURES", "CHANGES", "IMPROVEMENTS", "BUGFIXES"]
      changetype_match = Regexp.new(changetypes.map{|type| type + ":"}.join("|"))
      
      version_contents.each do |x|
        puts "Content"
        puts x
      end
      
      releases = versions.zip(version_contents).map do |x|
        version = x[0]
        content = x[1]
        
        changes = content.scan(changetype_match).map{|change| change[0..-2]}
        content_split = content.split(changetype_match).map{|x| x.gsub("\n", "")}.reject(&:empty?)
        
        entries = changes.zip(content_split).map do |change|
          strip_count = change[0] == "BUGFIXES" ? 3 : 2
          type = change[0].downcase[0..-strip_count]
          description = change[1]
          
          description.split("- ").reject(&:empty?).map{|x| ChangelogEntry.new(type, x)} 
        end
        
        entries = entries.flatten
        
        ReleaseEntry.new(version, entries)
      end
      
      releases
    end
end

class ReleaseEntry
  attr_accessor :version, :entries
  
  def initialize(version, entries)
    @version = version
    @entries = entries
  end
end

class ChangelogEntry
  attr_accessor :type, :description
  
  def initialize(type, description)
    @type = type
    @description = description
  end
end