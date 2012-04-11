module Yahoo
  module Content
    class InfoExtraction
      attr_reader :amplify
      attr_reader :content

      def initialize( yahoo_yml )
        prop = YAML::load_file( yahoo_yml )

        @output_path = prop[Yahoo::Runner::YahooConfigTag]['output_path']

        @amplify = Yahoo::Content::Amplify.new( yahoo_yml )
      end

      def extract( id, msg )
        # perform information extraction using Open Amplify API
        doc = @amplify.analyze_message( msg )

        save_results( doc, id )

        show_results( doc )
      end

      def show_results( doc )
        Parse::Amplify::parse( Parse::Amplify::top_topics( doc ) ) do |tn, weight, values|
          puts "[Top Topics => #{tn}, weight => #{weight}]"
          values.each {|val| val.each {|k,v| puts "#{k}=>#{v}"}}
        end

        Parse::Amplify::parse( Parse::Amplify::proper_nouns( doc ) ) do |tn, weight, values|
          puts "[Proper Noun => #{tn}, weight => #{weight}]"
          values.each {|val| val.each {|k,v| puts "#{k}=>#{v}"}}
        end
      end

      def save_results( nokogiri_doc, id )
        fn = File::join( @output_path, id.sub('html', 'xml') )
        f = File.open(fn, 'w')

        nokogiri_doc.write_to( f, :indent => 2 )

        f.close
      end
    end
  end
end