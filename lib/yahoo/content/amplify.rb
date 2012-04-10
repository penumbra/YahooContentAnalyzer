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

      attr_reader :results

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

        process_results( doc )
      end

      def process_results( doc )
        @results = Array.new

        topics = doc.xpath("//TopicResult")

        if topics != nil
          topics.each do |topic|
            tn = topic.xpath("Topic/Name/text()").to_s
            wt = topic.xpath("Topic/Value/text()").to_s

            @results << {:topic => tn, :weight => wt}

            named_entities = get_topic_values( topic )

            named_entities.each {|entity| @results << val }
          end
        end
      end

      def get_named_entities( topic )
        values = Array.new

        # check NamedEntityType within each topic
        topic.xpath("NamedEntityType").select do |entity|
          # NamedEntityType/Result/Name, etc.
          entity.xpath('Result').each do |result|
            values << {:entity => result.xpath('Name/text()').to_s,
                       :value => result.xpath('Value/text()').to_s}
          end
        end

        values
      end
    end
  end
end