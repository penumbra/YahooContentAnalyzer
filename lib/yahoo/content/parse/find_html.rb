require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Content
    module Parse
      # located an element by xpath within a specified HTML document
      class FindHtml < Yahoo::Shared::Finder
        # <abbr class="updated" title="2002-2-11T16:26:25Z">Mon Feb&nbsp;11,&nbsp;2002 4:26&nbsp;pm</abbr>
        GroupDateXPath = "//abbr[@class='updated']"
        GroupAuthorXPath = "//div[@class='vcard']/span[@class='email']"
        GroupTitleXPath = "//td[@class='ygrp-topic-title entry-title']"
        GroupContentXPath = "//div[@class='msgarea entry-content']"

        class << self
          def find_title( fn, xpath = GroupTitleXPath )
            node = Yahoo::Shared::Finder.find( fn, xpath )
            node.text
          end

          def find_date( fn, xpath = GroupDateXPath )
            node = Yahoo::Shared::Finder.find( fn, xpath )
            # title attribute
            node[0]['title'].chomp
          end

          def find_author( fn, xpath = GroupAuthorXPath )
            node = Yahoo::Shared::Finder.find( fn, xpath )

            idx = (node.text =~ /\</)
            if idx 
              node.text[0..idx-2]
            else
              nil
            end
          end

          def find_content( fn, xpath = GroupContentXPath )
            node = Yahoo::Shared::Finder.find( fn, xpath )
            node.text
          end
        end
      end
    end
  end
end
