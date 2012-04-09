require 'net/http'
require 'uri'
require 'rexml/document'

module Yahoo
  module Content
    class Amplify
      ApiKey = 'd2n25pnwuq688je3445a9bac36bqhtvr'
      ApiPort= 8180
      ApiHost= 'portaltnx20.openamplify.com'
      ApiPath= '/AmplifyWeb_v20/AmplifyThis'

      def initialize
        @http = Net::HTTP.new(ApiHost, ApiPort)
     end

      # Print the top ten things that the document author cares
      # about. Accepts a filename, a URL, or literal text.
      def analyze_message( msg )
        input_type= 'inputText'

        response = @http.post(ApiPath, "apiKey=#{ApiKey}&#{input_type}=#{URI::escape(msg)}")
        doc = REXML::Document.new(response.read_body)

        show_polarity( doc )
      end

      # Polarity is the attitude expressed towards a Topic in the text.
      def show_polarity( doc )
        important_topics= REXML::XPath.match(doc, "//TopicResult").select do |topic|
          REXML::XPath.match(topic, "Polarity/Mean/Name/text()") != 'Neutral'
        end

        important_topics.sort! do |a, b|
          a_importance= Float(REXML::XPath.match(a, "Polarity/Mean/Value/text()")[0].to_s).abs
          b_importance= Float(REXML::XPath.match(b, "Polarity/Mean/Value/text()")[0].to_s).abs
          a_importance <=> b_importance
        end

        important_topics[-10..-1].each do |topic|
          name= REXML::XPath.match(topic, "Topic/Name/text()")

          polarity= REXML::XPath.match(topic, "Polarity/Mean/Name/text()")
          puts "#{name}: #{polarity}"
        end
      end
    end
  end
end