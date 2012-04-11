module Yahoo
  module Content
    class InfoExtraction
      attr_reader :amplify
      attr_reader :content

      def initialize( yahoo_yml )
        prop = YAML::load_file( yahoo_yml )

        @data_path = prop[Yahoo::Runner::YahooConfigTag]['data_path']

        @amplify = Yahoo::Content::Amplify.new( yahoo_yml )
      end

      def extract( id, msg )
        # perform information extraction using Open Amplify API
        doc = @amplify.analyze_message( msg )

        save_results( doc, id )

        show_results( doc )
      end

      def show_results( doc )
        Amplify::parse( Amplify::top_topics( doc ) ) do |tn, weight, values|
          puts "[Top Topics => #{tn}, weight => #{weight}]"
          values.each {|val| val.each {|k,v| puts "#{k}=>#{v}"}}
        end

        Amplify::parse( Amplify::proper_nouns( doc ) ) do |tn, weight, values|
          puts "[Proper Noun => #{tn}, weight => #{weight}]"
          values.each {|val| val.each {|k,v| puts "#{k}=>#{v}"}}
        end
      end

      def save_results( nokogiri_doc, id )
        fn = File::join( @data_path, id.sub('html', 'xml') )
        f = File.open(fn, 'w')

        nokogiri_doc.write_to( f, :indent => 2 )

        f.close
      end
    end
  end
end