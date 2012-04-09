require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Content
    # scan a folder of html files to form an aggregate of unique topic names
    class ContentFinder < Yahoo::Finder
      GroupContentXPath = "//div[@class='msgarea entry-content']"

      def self.find_message( fn )
        find( fn, GroupContentXPath )
      end
    end
  end
end