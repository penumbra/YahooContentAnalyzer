module Yahoo
  module Topics
    # usage:
    #   tr = Topics::Runner( my_yaml_file )
    class Runner < Yahoo::Shared::Config
      attr_reader :topics

      def initialize
        super( $ConfigFile )

        # data_path, output_path, search_expr, ...
        add_properties!( Yahoo::Shared::Config::AppConfigTag )

        @topics = Set.new
      end

      # find the message-#####.html files and add the topic name to @topics
      def process_messages
        html_search = File.join( @data_path, @search_expr )
        entries = Dir.glob( html_search )

        entries.sort.each do |entry|
          puts "processing #{entry}"
          @topics << Yahoo::Content::Parse::FindHtml.find_topic( entry )
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
