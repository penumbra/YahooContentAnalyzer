require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Topics
    class TopicFinder < Yahoo::Finder
      GroupTopicXPath = "//td[@class='ygrp-topic-title entry-title']"

      def self.find_topic( fn )
        find( fn, GroupTopicXPath )
      end
    end
  end
end