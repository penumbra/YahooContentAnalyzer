#
# enables basic authentication using Yahoo.com
#
module Yahoo
  module Groups
    class Login
      BrowserType = 'Mac Safari'
      YahooLoginUrl = 'https://login.yahoo.com/config/login'

      # form name is found within the Yahoo login page
      YahooLoginForm = 'login_form'

      attr_reader :agent

      def initialize
        @agent = Mechanize.new

        @agent.follow_meta_refresh = true
        @agent.user_agent_alias = BrowserType
        @agent.idle_timeout = 10  # seconds
      end

      # use the Mechanize agent (@agent) to log into Yahoo
      def yahoo( username, password )
        login_form = @agent.get( YahooLoginUrl ).form( YahooLoginForm )

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
