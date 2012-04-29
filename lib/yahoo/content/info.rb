module Yahoo
  module Content
    class Info
      YamlHeader = "---"

      def initialize
        @html    = Analyze::Html.new

        @amplify = Analyze::Amplify.new
        @zemanta = Analyze::Zemanta.new
        @calais  = Analyze::Calais.new
      end

      def analyze( entry )
        # extract title, msg, date, author, and linked messages
        @html.analyze( entry )

        # perform information extraction
        @amplify.analyze( @html.msg )
        @zemanta.analyze( @html.msg )
        @calais.analyze( @html.title, @html.date, @html.msg )
      end

      def to_s
        puts YamlHeader
        @html.to_s if @html
        puts YamlHeader
        @amplify.to_s if @amplify && @amplify.doc
        puts YamlHeader
        @zemanta.to_s if @zemanta && @zemanta.doc
        puts YamlHeader
        @calais.to_s if @calais && @calais.doc
      end
    end
  end
end
