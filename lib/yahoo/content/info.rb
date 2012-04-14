module Yahoo
  module Content
    class Info < Yahoo::Config
      attr_reader :amplify
      attr_reader :content
      attr_reader :doc

      def initialize( yahoo_yml )
        super( yahoo_yml )

        @amplify = Yahoo::Content::Amplify.new( yahoo_yml )
      end

      def extract( msg )
        # perform information extraction using Open Amplify API
        @doc = @amplify.analyze_message( msg )
      end

      def to_s
        puts "---"

        Parse::Amplify::parse( Parse::Amplify::top_topics( @doc ) ) do |tn, weight, values|
          puts "[Top Topics => #{tn}, weight => #{weight}]"
          values.each {|val| val.each {|k,v| puts "#{k}=>#{v}"}}
        end

        Parse::Amplify::parse( Parse::Amplify::proper_nouns( @doc ) ) do |tn, weight, values|
          puts "[Proper Noun => #{tn}, weight => #{weight}]"
          values.each {|val| val.each {|k,v| puts "#{k}=>#{v}"}}
        end
      end
    end
  end
end