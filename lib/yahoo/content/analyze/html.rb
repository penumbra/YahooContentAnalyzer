module Yahoo
  module Content
    module Analyze
      class Html
        attr_reader :topic, :date, :author, :msg, :message_links, :email_links

        def initialize
          @message_links = []
          @email_links = []
        end

        def analyze( entry )
          @topic   = Parse::FindHtml.find_topic( entry )
          @date    = Parse::FindHtml.find_date( entry )
          @author  = Parse::FindHtml.find_author( entry )
          @msg     = Parse::FindHtml.find_content( entry )
          @message_links = Parse::FindHtml.find_links( entry )
        end

        def to_s
          puts "topic => #{@topic}"
          puts "date => #{@date}"
          puts "author => #{@author}"
          puts "linked messages => "
          if @message_links
            @message_links.each {|t| print "#{t} "}
            puts
          end
        end
      end
    end # Analyze
  end # Content
end # Yahoo
