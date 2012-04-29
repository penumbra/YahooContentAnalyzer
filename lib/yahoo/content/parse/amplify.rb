module Yahoo
  module Content
    module Parse
      # methods of extracting data from Amplify XML result doc
      class Amplify
        class << self
          begin
            # set xpath = ... constants
            prop = YAML::load_file( $ConfigFile )
            prop[ 'open_amplify_xpath' ].each { |key, value| const_set("#{key}", value) }
          end

          # process each of the top topics
          def parse_topics( doc )
            topic_results = doc.xpath( TopTopicsXPath )
            return if topic_results == nil

            topic_results.each do |topic_result|
              tn, wt, val = self.parse_results( topic_result )
              yield tn, wt, val
            end
          end

          # process each of the proper nouns
          def parse_nouns( doc )
            proper_nouns = doc.xpath( ProperNounsXPath )
            return if proper_nouns == nil

            proper_nouns.each do |topic_result|
              tn, wt, val = self.parse_results( topic_result )
              yield tn, wt, val
            end
          end

       protected
          # find NamedEntityType/Result info
          def parse_results( topic_result  )
            tn     = topic_result.search( TopicNameText ).to_s
            weight = topic_result.search( TopicValueText ).to_s
            values = self.get_named_entities( topic_result )

            return tn, weight, values
          end

          # returns an array of named entity information as hashes
          def get_named_entities( topic_result )
            result = []

            # check NamedEntityType within each topic
            entities = topic_result.search( NamedEntityXPath )

            entities.each do |entity|
              result << {:entity => entity.search( NameText ).to_s,
                         :value => entity.search( ValueText ).to_s }
            end

            result
          end
        end
      end
    end
  end
end