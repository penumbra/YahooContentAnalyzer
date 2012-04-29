module Yahoo
  module Content
    module Analyze
      class Html
        attr_reader :message_links
        attr_reader :email_links

        def initialize
          @message_links = []
          @email_links = []
        end

        def analyze( entry )
          @message_links = Parse::FindLinks.find( entry )
        end

        def to_s
          if @message_links
            print "linked messages => "
            @message_links.each {|t| print "#{t} "}
            puts
          end
        end
      end
    end # Analyze
  end # Content
end # Yahoo
