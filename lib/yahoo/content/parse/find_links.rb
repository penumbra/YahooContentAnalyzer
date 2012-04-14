require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Content
    # located an element by xpath within a specified HTML document
    class FindLinks < Yahoo::Finder
      MessageLinks = "//noscript/a"

      # <a href="/group/SynchronicityPhenomena/message/1336?threaded=1&var=1&l=1&p=15">
      #    <span>Re: Lucid Dreams synch</span>
      # </a>
      def self.find( fn, xpath = MessageLinks )
        node_list = super( fn, xpath )

        # return an array of id's representing other messages in the newsgroup thread
        get_ids( node_list )
      end

      # compile an array of related message id's
      def self.get_ids( node_list )
        ids = []

        if node_list != nil
          node_list.each do |node|
            id = get_id( node['href'] )

            ids << id.to_i unless id == nil
          end
        end

        ids
      end

      # use regex to extract the message id from a URL
      def self.get_id( href )
        if href =~ /p=[0-9]*$/
          href =~ /(message\/\d*)/
          match = $~

          match.string[match.begin(0)+"message/".size .. match.end(0)-1]
        else
          nil
        end
      end
    end
  end
end
