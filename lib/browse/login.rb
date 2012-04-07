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

    def yahoo( username, password )
      form_name = 'login_form'
      login_form = @agent.get( @url ).form( form_name )

      login_form.login = username
      login_form.passwd = password
 
      # returns Mechanize::Page
      @agent.submit( login_form, login_form.buttons.first )
    end
  end
end
