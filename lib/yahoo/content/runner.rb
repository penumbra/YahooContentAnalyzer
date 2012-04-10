module Yahoo
  module Content
    class Runner < Yahoo::Runner
      # File search path expression to find downloaded html files across folders
      SearchExpression = '**/message-*.html'

      attr_reader :content

      def initialize( yahoo_yml )
        super( yahoo_yml )

        @ie = Yahoo::Content::InfoExtraction.new
        @count = 0
      end

      # find the message-#####.html files and add the topic name to @topics
      def process_messages
        file_entries = Dir.glob( File.join( @data_path, SearchExpression ) )

        file_entries.sort.each do |entry|
          @count += 1

          @ie.extract( get_id( entry), Yahoo::Content::ContentFinder.find_message( entry ) )

          # debug
          return if @count > 3
        end
      end

      # relies on the construct from Yahoo::Groups module where downloaded files
      # are called 'message-#####.html'
      def get_id( entry )
        idx = entry =~ /message-[0-9]/
        max = entry.size - 1

        entry[idx..max]
      end
    end
  end
end