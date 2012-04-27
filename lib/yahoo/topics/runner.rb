module Yahoo
  module Topics
    # usage:
    #   tr = Topics::Runner( my_yaml_file )
    class Runner < Yahoo::Shared::Config
      # File search path expression to find downloaded html files across folders
      SearchExpression = '**/message-*.html'

      attr_reader :topics

      def initialize( yahoo_yml )
        super( yahoo_yml )
        @topics = Set.new
      end

      # find the message-#####.html files and add the topic name to @topics
      def process_messages
        html_search = File.join( @data_path, SearchExpression )
        entries = Dir.glob( html_search )

        entries.sort.each do |entry|
          puts "processing #{entry}"
          @topics << Yahoo::Topics::Parse::FindTopic.find( entry )
        end
      end

      def save_results( fn )
        f = File.open( File.join( @output_path, fn ), 'w' )

        @topics.sort.each {|t| f.puts t }
        f.close
      end
    end
  end
end
