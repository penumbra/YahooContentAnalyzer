require 'yaml'
require 'net/http'
require 'uri'

module Yahoo
  module Content
    module Analyze
      class Amplify < ApiConfig
        attr_reader :doc

        def initialize
          # api_key, input_type, host, port, path
          config!( 'open_amplify' )

          @http = Net::HTTP.new( @host, @port )
        end

        # return the Open Amplify API response as Nokogiri XML Doc
        def analyze( html )
          response = @http.post( @path, "apiKey=#{@api_key}&#{@input_type}=#{URI::escape( html.msg )}" )

          @doc = Nokogiri::XML( response.read_body )
        end

        def to_s
          Parse::Amplify::parse_topics( doc ) do |tn, weight, values|
            puts "[Top Topics => #{tn}, weight => #{weight}] => #{values}"
            # values.each {|val| val.each {|k,v| puts "#{k}=>#{v}"}}
          end

          Parse::Amplify::parse_nouns( doc ) do |tn, weight, values|
            puts "[Proper Noun => #{tn}, weight => #{weight}] => #{values}"
            # values.each {|val| val.each {|k,v| puts "#{k}=>#{v}"}}
          end
        end
      end
    end
  end
end