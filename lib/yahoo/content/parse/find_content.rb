require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Content
    module Parse
      # located an element by xpath within a specified HTML document
      class FindContent < Yahoo::Shared::Finder
        GroupContentXPath = "//div[@class='msgarea entry-content']"

        # <table class="headview headnav">
        GroupTitleXPath = "//td[@class='ygrp-topic-title entry-title']"

        # <abbr class="updated" title="2002-2-11T16:26:25Z">Mon Feb&nbsp;11,&nbsp;2002 4:26&nbsp;pm</abbr>
        GroupDateXPath = "//abbr[@class='updated']"

        class << self
          def find_msg( fn, xpath = GroupContentXPath )
            node = Yahoo::Shared::Finder.find( fn, xpath )
            node.text
          end

          def find_title( fn, xpath = GroupTitleXPath )
            node = Yahoo::Shared::Finder.find( fn, xpath )
            node.text
          end

          def find_date( fn, xpath = GroupDateXPath )
            node = Yahoo::Shared::Finder.find( fn, xpath )
            node.text
          end
        end
      end
    end
  end
end