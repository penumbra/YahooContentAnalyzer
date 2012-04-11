require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Topics
    # locate a specific element by xpath within the specified HTML document
    class Finder < Yahoo::Finder
      GroupTopicXPath = "//td[@class='ygrp-topic-title entry-title']"

      def self.find( fn, xpath = GroupTopicXPath )
        super( fn, xpath )
      end
    end
  end
end