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

      # example @results
      #
      # Key => 'John Smith' (a topic)
      # Value => Array[]
      #    {:weight => 5.0},
      #    {:entity => 'Type', :value => 'Person'},
      #    {:entity => 'SubType', :value => 'male'}
      #
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

        @results = Hash.new

        process_results( doc )
      end

      def process_results( doc )
        topic_results = doc.xpath("//TopicResult")

        return if topic_results == nil

        topic_results.each do |tr|
          tn = tr.xpath("Topic/Name/text()").to_s

          # add a weight info hash to the @results[key=tn] values
          values = Array.new
          values << {:weight => tr.search("Topic/Value/text()").to_s}

          # add the named entities to the @results[key=tn] => array
          values += get_named_entities( tr )

          # associated values with the @results[key=tn]
          @results[tn] = values
        end
      end

      # returns an array of named entity information as hashes
      def get_named_entities( topic_result )
        result = []
        # debug: puts "topic => #{topic.class} node => #{topic.name} value => #{tn}"

        # check NamedEntityType within each topic
        entities = topic_result.search('NamedEntityType/Result')

        entities.each do |entity|
          result << {:entity => entity.search('Name/text()').to_s,
                     :value => entity.search('Value/text()').to_s }
        end

        result
      end
    end
  end
end