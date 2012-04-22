module Yahoo
  module Content
    module Parse
      # methods of extracting data from Amplify XML result doc
      class Amplify
        def self.parse_topics( doc )
          topic_results = Parse::Amplify.top_topics( doc )
          return if topic_results == nil

          topic_results.each do |topic_result|
            tn, wt, val = self.parse_results( topic_result )
            yield tn, wt, val
          end
        end

        def self.parse_nouns( doc )
          proper_nouns = Parse::Amplify.proper_nouns( doc )
          return if proper_nouns == nil

          proper_nouns.each do |topic_result|
            tn, wt, val = self.parse_results( topic_result )
            yield tn, wt, val
          end
        end

     protected
        TopTopicsXPath = "//TopTopics/TopicResult"
        ProperNounsXPath = "//ProperNouns/TopicResult"
        NamedEntityXPath = 'NamedEntityType/Result'

        def self.top_topics( doc )
          doc.xpath( TopTopicsXPath )
        end

        def self.proper_nouns( doc )
          doc.xpath( ProperNounsXPath )
        end

        # find NamedEntityType/Result info
        def self.parse_results( topic_result  )
          tn     = topic_result.search("Topic/Name/text()").to_s
          weight = topic_result.search("Topic/Value/text()").to_s
          values = self.get_named_entities( topic_result )

          return tn, weight, values
        end

        # returns an array of named entity information as hashes
        def self.get_named_entities( topic_result )
          result = []

          # check NamedEntityType within each topic
          entities = topic_result.search( NamedEntityXPath )

          entities.each do |entity|
            result << {:entity => entity.search('Name/text()').to_s,
                       :value => entity.search('Value/text()').to_s }
          end

          result
        end
      end
    end
  end
end