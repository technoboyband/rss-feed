#!/usr/bin/env ruby
require 'rss'
require 'open-uri'

#if param is url but not valid rss feed, rss library will throw error
#other param output shouldnt be affected
def verifyURL(url)
    uri = URI.parse(url);
    uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
    false
end

def printRSSItems
    ARGV.each do|a|
        if verifyURL(a)
            URI.open(a) do |rss|
                feed = RSS::Parser.parse(rss)
                puts "RSS Channel: #{feed.channel.title}"
                feed.items.each do |item|
                    puts " > Item: #{item.title}"
                    puts "\tDate Published: #{item.pubDate}"
                    puts
                end
            end 
        else
            puts a + " is an invalid url."
        end
    end
    return 
end

puts "~~~ rss feed viewer ~~~"
puts

printRSSItems