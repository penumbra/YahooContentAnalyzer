require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Topics
    # scan a folder of html files to form an aggregate of unique topic names
    class Finder
      GroupTopicXPath = "//td[@class='ygrp-topic-title entry-title']"

      # a collection of unique Yahoo Group Topic names
      attr_reader :topics

      # path to folder containing Yahoo Group html files
      def initialize( path )
        @path = path
        @topics = Set.new
      end

      def parse_files
        entries = Dir.entries( @path )

        entries.sort.each do |fn|
          if File.directory?( fn ) == false
            find_topic( fn )
          end
        end
      end

  private
      def find_topic( fn )
        f = File.open( File.join( @path, fn) )

        html = Nokogiri::HTML(f)
        node = html.xpath(GroupTopicXPath)
        @topics << node.text
      rescue Exception => ex
        puts "Error with file #{fn} - #{ex}"
      ensure
        f.close
      end
    end
  end
end