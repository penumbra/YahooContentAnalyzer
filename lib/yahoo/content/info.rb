module Yahoo
  module Content
    class Info < Yahoo::Shared::Config
      attr_reader :amplify
      attr_reader :zemanta

      def initialize( yahoo_yml )
        super( yahoo_yml )

        @amplify = Yahoo::Content::Amplify.new( yahoo_yml )
        @zemanta = Yahoo::Content::Zemanta.new( yahoo_yml )
      end

      def analyze( msg )
        # perform information extraction using Open Amplify API
        @amplify.analyze( msg )

        # perform information extraction using Zemanta API
        @zemanta.analyze( msg )
      end

      def to_s
        Parse::Amplify::parse_topics( @amplify.doc ) do |tn, wt, vals|
          puts "top topics #{tn}, #{wt} => #{vals}"
        end

        Parse::Amplify::parse_nouns( @amplify.doc ) do |tn, wt, vals|
          puts "proper nouns #{tn}, #{wt} => #{vals}"
        end

        Parse::Zemanta::parse_keywords( @zemanta.doc ) do |kw|
          puts "keyword = #{kw}"
        end
      end
    end
  end
end