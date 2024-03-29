#
# enables basic authentication using Yahoo.com
#
module Yahoo
  module Groups

    class Login < Yahoo::Shared::AppConfig
      attr_reader :agent

      def initialize
        # login, password, login_url, login_form, browser_type, idle_timeout_sec
        config!( 'yahoo' )

        @agent = Mechanize.new
        @agent.follow_meta_refresh = true
        @agent.user_agent_alias = @browser_type
        @agent.idle_timeout = @idle_timeout_sec  # seconds

        # use the Mechanize agent (@agent) to log into Yahoo
        login
      end

      def login
        login_form = @agent.get( @login_url ).form( @login_form )

        # basic authentication parameters
        login_form.login = @login_id
        login_form.passwd = @password

        # returns Mechanize::Page
        @agent.submit( login_form, login_form.buttons.first )

        puts "yahoo login successful..."
      end
    end

  end # Groups
end # Yahoo
