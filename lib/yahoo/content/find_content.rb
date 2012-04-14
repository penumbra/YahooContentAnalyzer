require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Content
    # located an element by xpath within a specified HTML document
    class FindContent < Yahoo::Finder
      GroupContentXPath = "//div[@class='msgarea entry-content']"

      def self.find( fn, xpath = GroupContentXPath )
        node = super( fn, xpath )

        node.text
      end
    end
  end
end