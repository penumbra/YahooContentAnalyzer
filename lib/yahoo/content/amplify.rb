require 'yaml'
require 'net/http'
require 'uri'

module Yahoo
  module Content
    class Amplify
      ApiPort= 8180
      ApiHost= 'portaltnx20.openamplify.com'
      ApiPath= '/AmplifyWeb_v20/AmplifyThis'

      attr_reader :doc

      def initialize( yahoo_yml )
        prop = YAML::load_file( yahoo_yml )

        @api_key = prop['open_amplify']['api_key']

        @http = Net::HTTP.new(ApiHost, ApiPort)
      end

      # return the Open Amplify API response as Nokogiri XML Doc
      def analyze( msg )
        input_type= 'inputText'

        response = @http.post(ApiPath, "apiKey=#{@api_key}&#{input_type}=#{URI::escape(msg)}")

        @doc = Nokogiri::XML( response.read_body )
      end

      def to_s
        Parse::Amplify::parse_topics( doc ) do |tn, weight, values|
          puts "[Top Topics => #{tn}, weight => #{weight}]"
          values.each {|val| val.each {|k,v| puts "#{k}=>#{v}"}}
        end

        Parse::Amplify::parse_nouns( doc ) do |tn, weight, values|
          puts "[Proper Noun => #{tn}, weight => #{weight}]"
          values.each {|val| val.each {|k,v| puts "#{k}=>#{v}"}}
        end
      end
    end
  end
end