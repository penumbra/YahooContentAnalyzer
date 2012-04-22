module Yahoo
  module Content
    #
    # This is a work-in-progress.
    #
    # Presently, it performs information extraction on
    # one of 30,000 messages
    #
    class Runner < Yahoo::Shared::Config
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
            puts "MESSAGE ID #{@idx}"

            # information extraction
            @ie.analyze( entry )

            @ie.to_s
            return # short-circuit exit
          end
        end
      end

      # save Nokogiri::XML doc => @output_path/message-#####.xml
      def save_results( doc, id )
        fn = File::join( @output_path, id.sub('html', 'xml') )
        f = File.open(fn, 'w')

        doc.write_to( f, :indent => 2 )

        f.close
      end

      # relies on the construct from Yahoo::Groups module where downloaded files
      # are called 'message-#####.html'
      def get_id( entry )
        entry =~ /(message-\d*)/
        match = $~

        # get the numeric part only
        match.string[match.begin(0) .. match.end(0)-1]
      end
    end
  end
end