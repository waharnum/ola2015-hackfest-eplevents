require 'nokogiri'
require 'open-uri'

class Branch
	attr_accessor :name
	attr_accessor :latitude
	attr_accessor :longitude

	def initialize(name, latitude, longitude)
		@name = name;
		@latitude = latitude;
		@longitude = longitude
	end
end 

doc = Nokogiri::XML(open("http://www.epl.ca/branches.xml"))      
doc.encoding = 'utf-8'

puts "["
doc.xpath("//BranchInfo").each do | branch |
	curr_branch = Branch.new(branch.xpath("Name").inner_html, branch.xpath("Coordinates/Latitude").inner_html, branch.xpath("Coordinates/Longitude").inner_html)
	#TODO: make better JSON generation (including not outputting last comma :()
	puts "{\"branch\": \"#{curr_branch.name}\",\"lat\": #{curr_branch.latitude}, \"long\": #{curr_branch.longitude}},"
end
puts "]"

