#
# Uses the browse classes to provide access to messages within a Yahoo Group
#
module Yahoo
  module Groups
    class Reader
      attr_reader :login
      attr_reader :yahoo_page

      def initialize
        # group_host, group_name
        prop = YAML::load_file( $ConfigFile )
        prop[ 'yahoo' ].each { |k, v| instance_variable_set("@#{k}", v) }

        @login = Yahoo::Groups::Login.new

        @yahoo_page = Browse::Content.new( @login.agent )
      end

      # console list of groups associated with the current yahoo account
      def list_groups
        list = []

        @yahoo_page.get_links_at( @group_host ).each do |link|
          if link.href =~ /^\/group/
            puts "#{link.text}"
            list << link.text
          end
        end

        list
      end

      # returns html page or nil if page is not found
      def select_group
        page = @yahoo_page.click_link_with_title( @group_host, @group_name )

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