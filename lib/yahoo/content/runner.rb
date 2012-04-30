module Yahoo
  module Content
    class Runner < Yahoo::Shared::AppConfig
      attr_reader :content

      def initialize
        super
        @ie = Yahoo::Content::Info.new

        @idx = ( rand * 30000 ).to_i
      end

      # scan the @data_path folder for message-#####.html file
      def process_messages
        count = 0; file_entries = Dir.glob( File.join( @data_path, @search_expr ) )

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
      # using indent_xml_size from yaml
      def save_results( doc, id )
        fn = File::join( @output_path, id.sub('html', 'xml') )
        f = File.open(fn, 'w')

        doc.write_to( f, :indent => @indent_xml_size )

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
