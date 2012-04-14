require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Topics
    module Parse
      # locate a specific element by xpath within the specified HTML document
      class FindTopic < Yahoo::Finder
        GroupTopicXPath = "//td[@class='ygrp-topic-title entry-title']"

        def self.find( fn, xpath = GroupTopicXPath )
          node = super( fn, xpath )

          node.text if node
        end
      end
    end
  end
end
