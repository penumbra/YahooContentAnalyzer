module Yahoo
  module Content
    module Analyze
      class Html
        attr_reader :msg
        attr_reader :title
        attr_reader :date
        attr_reader :author
        attr_reader :message_links
        attr_reader :email_links

        def initialize
          @message_links = []
          @email_links = []
        end

        def analyze( entry )
          @title  = Parse::FindHtml.find_title( entry )
          @date   = Parse::FindHtml.find_date( entry )
          @author = Parse::FindHtml.find_author( entry )
          @msg     = Parse::FindHtml.find_content( entry )
          @message_links = Parse::FindHtml.find_links( entry )
        end

        def to_s
          puts "title => #{@title}"
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
