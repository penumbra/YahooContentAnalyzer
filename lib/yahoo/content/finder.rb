require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Content
    # located an element by xpath within a specified HTML document
    class Finder < Yahoo::Finder
      GroupContentXPath = "//div[@class='msgarea entry-content']"

      def self.find( fn )
        find( fn, GroupContentXPath )
      end
    end
  end
end