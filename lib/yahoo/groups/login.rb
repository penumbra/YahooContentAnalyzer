#
# enables basic authentication using Yahoo.com
#
module Yahoo
  module Groups
    class Login
      BrowserType = 'Mac Safari'
      YahooLogin = 'https://login.yahoo.com/config/login'

      attr_reader :agent

      def initialize
        @agent = Mechanize.new

        @agent.follow_meta_refresh = true
        @agent.user_agent_alias = BrowserType
        @agent.idle_timeout = 10  # seconds
      end

      # use the Mechanize agent (@agent) to log into Yahoo
      def yahoo( username, password )
        # form name is found within the Yahoo login page
        form_name = 'login_form'

        # @url set by Object owner (e.g. YahooLogin)
        login_form = @agent.get( YahooLogin ).form( form_name )

        # basic authentication parameters
        login_form.login = username
        login_form.passwd = password

        # returns Mechanize::Page
        @agent.submit( login_form, login_form.buttons.first )

        puts "yahoo login successful..."
      end
    end
  end
end
