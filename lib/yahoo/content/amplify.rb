require 'yaml'
require 'net/http'
require 'uri'
require 'rexml/document'

module Yahoo
  module Content
    class Amplify
      ApiPort= 8180
      ApiHost= 'portaltnx20.openamplify.com'
      ApiPath= '/AmplifyWeb_v20/AmplifyThis'

      # example @results
      #
      # Key => 'John Smith' (a topic)
      # Value => Array[]
      #    {:weight => 5.0},
      #    {:entity => 'Type', :value => 'Person'},
      #    {:entity => 'SubType', :value => 'male'}
      #
      attr_reader :results

      def initialize( yahoo_yml )
        prop = YAML::load_file( yahoo_yml )

        @api_key = prop['open_amplify']['api_key']

        @http = Net::HTTP.new(ApiHost, ApiPort)
      end

      # Print the top ten things that the document author cares
      # about.
      # input accepts a filename, a URL, or literal text.
      def analyze_message( msg )
        input_type= 'inputText'

        response = @http.post(ApiPath, "apiKey=#{@api_key}&#{input_type}=#{URI::escape(msg)}")

        Nokogiri::XML( response.read_body )
      end
    end
  end
end