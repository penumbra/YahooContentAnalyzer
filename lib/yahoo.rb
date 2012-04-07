require 'browse'

class Yahoo
  YahooLogin = 'https://login.yahoo.com/config/login'
  YahooGroups = 'http://groups.yahoo.com'

  attr_reader :url
  attr_reader :login
  attr_reader :yahoo_page

  def initialize( username, password )
    @url = YahooLogin

    @login = Browse::Login.new( @url )
    @login.yahoo( username, password )
    puts "yahoo login successful..."

    @yahoo_page = Browse::Content.new( @login.agent )
  end

  # console list of groups associated with this yahoo account
  def list_groups
    @yahoo_page.get_links_at( YahooGroups ).each do |link|
      if link.href =~ /^\/group/
        puts "link => #{link.text}"
      end
    end
  end

  # returns html page or nil if not found
  def select_group( group_title )
    page = @yahoo_page.click_link_with_title( YahooGroups, group_title )

    @groups_uri = page.uri

    (page != nil) ? page.body : nil
  end

  def get_message( id )
    uri = @groups_uri + "message/#{id}"
    page = @yahoo_page.set_page_at( uri )

    (page != nil) ? page.body : nil
  end
end
