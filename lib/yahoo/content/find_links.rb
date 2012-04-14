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

        puts "here"
        # return an array of id's representing other messages in the newsgroup thread
        get_ids( node_list )
      end

      # use regex to compile an array of related message id's
      def self.get_ids( node_list )
        ids = []

        if node_list != nil
          node_list.each do |node|
            href = "node => #{node['href']}"

            if href =~ /p=[0-9]*$/
              href =~ /(message\/\d*)/
              match = $~

              # get the numeric part only
              id = match.string[match.begin(0)+8 .. match.end(0)-1]

              # convert to an integer before adding to array
              ids << id.to_i
            end
          end
        end

        ids
      end
    end
  end
end
