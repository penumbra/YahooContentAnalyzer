module Yahoo
  module Content
    class Info
      YamlHeader = "---"

      def initialize
        @amplify = Analyze::Amplify.new
        @zemanta = Analyze::Zemanta.new
        @calais  = Analyze::Calais.new
        @html    = Analyze::Html.new
      end

      def analyze( entry )
        # find related messages for this topic/title
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
