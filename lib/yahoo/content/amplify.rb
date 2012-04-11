require 'yaml'
require 'net/http'
require 'uri'

module Yahoo
  module Content
    class Amplify
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

      def self.top_topics( doc )
        doc.xpath("//TopTopics/TopicResult")
      end

      def self.proper_nouns( doc )
        doc.xpath("//ProperNouns/TopicResult")
      end

      def self.parse( topic_results )
        return if topic_results == nil

        topic_results.each do |topic_result|
          tn     = topic_result.search("Topic/Name/text()").to_s
          weight = topic_result.search("Topic/Value/text()").to_s

          # find NamedEntityType/Result info
          values = self.get_named_entities( topic_result )
          yield( tn, weight, values )
        end
      end

      # returns an array of named entity information as hashes
      def self.get_named_entities( topic_result )
        result = []

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