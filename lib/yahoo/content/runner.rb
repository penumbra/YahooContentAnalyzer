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

            # send the message content to information extraction
            @ie.analyze( Yahoo::Content::Parse::FindContent.find( entry ) )

            save_results( @ie.amplify.doc, get_id( entry ) )

            # show info extraction and id's of other messages in the thead
            @ie.to_s

            show_linked_messages( FindLinks.find( entry ) )
            return # exit
          end
        end
      end

      def show_linked_messages( email_links )
        if email_links
          print "linked messages=>"
          email_links.each {|t| print "#{t} "}
          puts
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