module Yahoo
  module Content
    class Runner < Yahoo::Config
      # File search path expression to find downloaded html files across folders
      SearchExpression = '**/message-*.html'

      attr_reader :content

      def initialize( yahoo_yml )
        super( yahoo_yml )

        @ie = Yahoo::Content::Info.new( yahoo_yml )

        @idx = Random.rand(1..30000)
      end

      # scan the @data_path folder for message-#####.html file
      def process_messages
        count = 0; file_entries = Dir.glob( File.join( @data_path, SearchExpression ) )

        file_entries.sort.each do |entry|
          count += 1

          if count == @idx
            id = get_id( entry )

            # send the message content to information extraction
            doc = @ie.extract( id, Yahoo::Content::Parse::FindContent.find( entry ) )

            puts "---"
            @ie.show_results( doc )

            return # exit
          end
       end
      end

      # relies on the construct from Yahoo::Groups module where downloaded files
      # are called 'message-#####.html'
      def get_id( entry )
        entry =~ /(message-\d*)/
        match = $~

        # get the numeric part only
        id = match.string[match.begin(0) .. match.end(0)-1]
      end
    end
  end
end
