require 'yaml'
require 'net/http'
require 'uri'

module Yahoo
  module Content
    class Amplify
      include Yahoo::Content::AmplifyParse

      ApiPort= 8180
      ApiHost= 'portaltnx20.openamplify.com'
      ApiPath= '/AmplifyWeb_v20/AmplifyThis'

      def initialize( yahoo_yml )
        prop = YAML::load_file( yahoo_yml )

        @api_key = prop['open_amplify']['api_key']

        @http = Net::HTTP.new(ApiHost, ApiPort)
      end

      # return the Open Amplify API response as Nokogiri XML Doc
      def analyze_message( msg )
        input_type= 'inputText'

        response = @http.post(ApiPath, "apiKey=#{@api_key}&#{input_type}=#{URI::escape(msg)}")

        Nokogiri::XML( response.read_body )
      end
    end
  end
end