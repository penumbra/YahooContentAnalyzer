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

      attr_reader :topics

      def initialize
        @http = Net::HTTP.new(ApiHost, ApiPort)
     end

      # Print the top ten things that the document author cares
      # about.
      # input accepts a filename, a URL, or literal text.
      def analyze_message( msg )
        input_type= 'inputText'

        response = @http.post(ApiPath, "apiKey=#{ApiKey}&#{input_type}=#{URI::escape(msg)}")

        doc = Nokogiri::XML( response.read_body )

        @topics = Hash.new

        show_topics( doc )
      end

      def show_topics( doc )
        important_topics = doc.xpath("//TopicResult")

        puts "topics size: #{important_topics.size}"

        important_topics.each do |topic|
          values = Array.new

          topic_name = topic.xpath("Topic/Name/text()").to_s

          values << {:name => topic_name, :weight => topic.xpath("Topic/Value/text()").to_s }

          topic.xpath("NamedEntityType").select do |entity|

            # populated with one or more named entity name/value pairs
            entity.xpath('Result').each do |result|
              name = result.xpath('Name/text()').to_s
              value = result.xpath('Value/text()').to_s

              values << {:entity => name, :value => value}
            end
          end

          @topics[topic_name] = values
        end
      end

      # Polarity is the attitude expressed towards a Topic in the text.
      def show_rexml_polarity( doc )
        important_topics = REXML::XPath.match(doc, "//TopicResult").select do |topic|
          REXML::XPath.match(topic, "Polarity/Mean/Name/text()") != 'Neutral'
        end

        important_topics.sort! do |a, b|
          a_importance = Float(REXML::XPath.match(a, "Polarity/Mean/Value/text()")[0].to_s).abs
          b_importance = Float(REXML::XPath.match(b, "Polarity/Mean/Value/text()")[0].to_s).abs
          a_importance <=> b_importance
        end

        important_topics[-10..-1].each do |topic|
          name = REXML::XPath.match(topic, "Topic/Name/text()")

          polarity = REXML::XPath.match(topic, "Polarity/Mean/Name/text()")
          puts "#{name}: #{polarity}"
        end

      end
    end
  end
end