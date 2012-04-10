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

      # example @results array of hashes
      #
      # {:topic => 'Uploaded', :weight => '5.0'}
      # {:entity => 'Type', :value => 'Person'}
      # {:entity => 'SubType', :value => 'male'}
      #
      def process_results( doc )
        @results = Array.new

        topics = doc.xpath("//TopicResult")

        if topics != nil
          topics.each do |topic|
            @results << {:topic => topic.xpath("Topic/Name/text()").to_s,
                         :weight => topic.xpath("Topic/Value/text()").to_s}

            ne = get_named_entities( topic )
            ne.each {|hash| @results << hash }
          end
        end
      end

      # returns an array of named entity information as hashes
      def get_named_entities( topic )
        values = Array.new

        # check NamedEntityType within each topic
        topic.xpath("NamedEntityType").select do |entity|
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