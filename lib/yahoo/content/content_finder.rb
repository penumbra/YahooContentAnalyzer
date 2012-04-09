require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Content
    # scan a folder of html files to extract the message content
    class ContentFinder < Yahoo::Finder
      GroupContentXPath = "//div[@class='msgarea entry-content']"

      def self.find_message( fn )
        find( fn, GroupContentXPath )
      end
    end
  end
end