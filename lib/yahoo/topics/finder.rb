require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Topics
    # scan a folder of html files to form an aggregate of unique topic names
    class Finder
      GroupTopicXPath = "//td[@class='ygrp-topic-title entry-title']"

      def self.find_topic( fn )
        f = File.open( fn )
        html = Nokogiri::HTML( f )

        node = html.xpath(GroupTopicXPath)

        # topic is returned to caller as text
        node.text
      rescue Exception => ex
        puts "Error with file #{fn} - #{ex}"
        nil  # nil topic name is returned
      ensure
        f.close
      end
    end
  end
end