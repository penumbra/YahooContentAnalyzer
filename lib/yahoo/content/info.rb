module Yahoo
  module Content
    class Info < Yahoo::Shared::Config
      YamlHeader = "---"
      attr_reader :amplify
      attr_reader :zemanta
      attr_reader :calais

      def initialize( yahoo_yml )
        super( yahoo_yml )

        @amplify = Amplify.new( yahoo_yml )
        @zemanta = Zemanta.new( yahoo_yml )
        @calais  = Calais.new( yahoo_yml )
        @links   = Links.new
      end

      def analyze( entry )
        @title = Parse::FindContent.find_title( entry )
        @date  = Parse::FindContent.find_date( entry )
        msg    = Parse::FindContent.find_msg( entry )

        # perform information extraction using Open Amplify API
        @amplify.analyze( msg )

        # perform information extraction using Zemanta API
        @zemanta.analyze( msg )

        # perform information extraction using Open Calais API
        @calais.analyze( @title, msg, @date )

        # find related messages for this topic/title
        @links.analyze( entry )
      end

      def to_s
        puts "title => #{@title}, date => #{@date}"
        puts YamlHeader
        @amplify.to_s if @amplify && @amplify.doc
        puts YamlHeader
        @zemanta.to_s if @zemanta && @zemanta.doc
        puts YamlHeader
        @calais.to_s if @calais && @calais.doc
        puts YamlHeader
        @links.to_s if @links
      end
    end
  end
end