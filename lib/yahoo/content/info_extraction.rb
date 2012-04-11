module Yahoo
  module Content
    class InfoExtraction
      attr_reader :amplify
      attr_reader :content

      def initialize( yahoo_yml )
        @content = Hash.new

        prop = YAML::load_file( yahoo_yml )

        @data_path = prop[Yahoo::Runner::YahooConfigTag]['data_path']

        @amplify = Yahoo::Content::Amplify.new( yahoo_yml )
      end

      def extract( id, msg )
        # add to a hash containing of all message content
        @content[id] = msg

        # perform information extraction using Open Amplify API
        doc = @amplify.analyze_message( msg )

        save( doc, id )

        parse_results_xml( doc )
      end

      def parse_results_xml( doc )
        show_results( doc.xpath("//TopTopics/TopicResult"), 'top topic' )
        show_results( doc.xpath("//ProperNouns/TopicResult"), 'proper noun' )
      end

      def show_results( ttr, desc )
        return if ttr == nil

        ttr.each do |topic_result|
          tn = topic_result.search("Topic/Name/text()").to_s
          weight = topic_result.search("Topic/Value/text()").to_s

          puts "[#{desc} => #{tn}, weight => #{weight}]"

          # add the named entities to the @results[key=tn] => array
          values = []
          values += get_named_entities( topic_result )

          values.each {|val| val.each {|k,v| puts "#{k}=>#{v}"}}
        end
      end

      # returns an array of named entity information as hashes
      def get_named_entities( topic_result )
        result = []

        # check NamedEntityType within each topic
        entities = topic_result.search('NamedEntityType/Result')

        entities.each do |entity|
          result << {:entity => entity.search('Name/text()').to_s,
                     :value => entity.search('Value/text()').to_s }
        end

        result
      end

      def save( nokogiri_doc, id )
        fn = File::join( @data_path, id.sub('html', 'xml') )
        f = File.open(fn, 'w')

        nokogiri_doc.write_to( f, :indent => 2 )

        f.close
      end
    end
  end
end