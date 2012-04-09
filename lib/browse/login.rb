#
# enables basic authentication using Yahoo.com
#
module Browse
  BrowserType = 'Mac Safari'

  class Login
    attr_reader :agent
    attr_reader :url

    def initialize( url )
      @url = url

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
      login_form = @agent.get( @url ).form( form_name )

      # basic authentication parameters
      login_form.login = username
      login_form.passwd = password
 
      # returns Mechanize::Page
      @agent.submit( login_form, login_form.buttons.first )
    end
  end
end
