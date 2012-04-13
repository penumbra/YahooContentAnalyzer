module Yahoo
  module Content
    class Info < Yahoo::Config
      attr_reader :amplify
      attr_reader :content

      def initialize( yahoo_yml )
        super( yahoo_yml )

        @amplify = Yahoo::Content::Amplify.new( yahoo_yml )
      end

      def extract( id, msg, save = true)
        # perform information extraction using Open Amplify API
        doc = @amplify.analyze_message( msg )

        save_results( doc, id ) if save

        doc
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

      def save_results( doc, id )
        fn = File::join( @output_path, id.sub('html', 'xml') )
        f = File.open(fn, 'w')

        doc.write_to( f, :indent => 2 )

        f.close
      end
    end
  end
end