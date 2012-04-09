module Yahoo
  module Topics
    # usage:
    #   tr = Topics::Runner( my_yaml_file )
    #
    class Runner
      # Tag used in YAML file to identify the Yahoo configuration block
      YahooConfigTag = 'yahoo'
      # File search path expression to find downloaded html files across folders
      SearchExpression = '**/message-*.html'

      attr_reader :topics

      def initialize( yahoo_yml )
        prop = YAML::load_file( yahoo_yml )

        # create instance variables from the yahoo: group properties
        prop[YahooConfigTag].each { |key, value| instance_variable_set("@#{key}", value) }

        @topics = Set.new
      end

      # find the message-#####.html files and add the topic name to @topics
      def process_messages
        html_search = File.join( @data_path, SearchExpression )
        entries = Dir.glob( html_search )

        entries.sort.each do |entry|
          puts "processing #{entry}"
          @topics << Yahoo::Topics::Finder.find_topic( entry )
        end
      end

      def save_results( fn )
        f = File.open( fn, 'w' )

        topic_runner.topics.sort.each {|t| f.puts t }

        f.close
      end
    end
  end
end