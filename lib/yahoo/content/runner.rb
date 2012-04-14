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

      # find the message-#####.html files and add the topic name to @topics
      def process_messages
        count = 0; file_entries = Dir.glob( File.join( @data_path, SearchExpression ) )

        file_entries.sort.each do |entry|
          count += 1

          # newsgroup topic "Codex", message id=21753
          if count == @idx
            id = get_id( entry )

            puts "processing #{id}"
            doc = @ie.extract( id, Yahoo::Content::Parse::Finder.find( entry ) )

            puts "---"
            @ie.show_results( doc )

            return # exit
          end
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
