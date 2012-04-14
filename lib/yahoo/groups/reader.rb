#
# Uses the browse classes to provide access to messages within a Yahoo Group
#
module Yahoo
  module Groups
    class Reader
      YahooGroups = 'http://groups.yahoo.com'

      attr_reader :login
      attr_reader :yahoo_page

      def initialize( username, password )
        @login = Yahoo::Groups::Login.new( username, password )

        @yahoo_page = Browse::Content.new( @login.agent )
      end

      # console list of groups associated with the current yahoo account
      def list_groups
        list = []

        @yahoo_page.get_links_at( YahooGroups ).each do |link|
          if link.href =~ /^\/group/
            puts "#{link.text}"
            list << link.text
          end
        end

        list
      end

      # returns html page or nil if page is not found
      def select_group( group_title )
        page = @yahoo_page.click_link_with_title( YahooGroups, group_title )

        @groups_uri = page.uri

        (page != nil) ? page.body : nil
      end

      # returns an html page or nil if page is not found
      def get_message( id )
        uri = @groups_uri + "message/#{id}"
        page = @yahoo_page.set_page_at( uri )

        (page != nil) ? page.body : nil
      end
    end
  end
end