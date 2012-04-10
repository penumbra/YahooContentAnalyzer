module Yahoo
  module Content
    class Runner < Yahoo::Runner
      # File search path expression to find downloaded html files across folders
      SearchExpression = '**/message-*.html'

      attr_reader :content

      def initialize( yahoo_yml )
        super( yahoo_yml )
        @content = Hash.new
        @amplify = Yahoo::Content::Amplify.new
      end

      # find the message-#####.html files and add the topic name to @topics
      def process_messages
        html_search = File.join( @data_path, SearchExpression )
        entries = Dir.glob( html_search )

        count = 0

        entries.sort.each do |entry|
          count += 1

          extract_message_information( entry )

          return if count >= 20
        end
      end

      def extract_message_information( entry )
        # console puts "processing #{msg_id}"
        message = Yahoo::Content::ContentFinder.find_message( entry )

        # add to a hash containing of all message content
        @content.merge!( {:id => get_id( entry ), :content => message } )

        # perform information extraction using Open Amplify API
        @amplify.analyze_message( message )

        report_results
      end

      def report_results
        @amplify.topics.each do |key, values|
          puts "#{key} [ #{values} ]"
        end
      end

      def get_id( entry )
        idx = entry =~ /message-[0-9]/
        max = entry.size - 1

        entry[idx..max]
      end
    end
  end
end