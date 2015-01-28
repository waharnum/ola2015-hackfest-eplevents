require 'nokogiri'
require 'open-uri'
require 'csv'

class Event

	attr_accessor :subject
	attr_accessor :start_time
	attr_accessor :end_time
	attr_accessor :notes
	attr_accessor :location
	attr_accessor :weblink
	
	def initialize(subject, start_time, end_time, notes, location, weblink)
		@subject = subject
		@start_time = start_time
		@end_time = end_time
		@notes = notes
		@location = location
		@weblink = weblink
	end
end 

doc = Nokogiri::XML(open("http://www.epl.ca/opendata/events/api/2015-01-28/2015-01-28/"))      
doc.encoding = 'utf-8'

events = Array.new

doc.xpath("//event").each do | event |
	su = event.xpath("subject").inner_html
	st = event.xpath("starttime").inner_html
	et = event.xpath("endtime").inner_html
	nt = event.xpath("notes").inner_html
	lo = event.xpath("location").inner_html
	wl = event.xpath("weblink").inner_html
	curr_event = Event.new(su,st,et,nt,lo,wl)
	events.push(curr_event)	
end

events.each do | event |
	puts "\"#{event.subject}\",#{event.start_time},#{event.end_time},\"#{event.notes}\",\"#{event.location}\",#{event.weblink}" 
end