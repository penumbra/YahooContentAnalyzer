module Yahoo
  module Content
    class Info < Yahoo::Shared::Config
      YamlHeader = "---"

      def initialize( yahoo_yml )
        super( yahoo_yml )

        @amplify = Analyze::Amplify.new( yahoo_yml )
        @zemanta = Analyze::Zemanta.new( yahoo_yml )
        @calais  = Analyze::Calais.new( yahoo_yml )
        @html    = Analyze::Html.new
      end

      def analyze( entry )
        @title  = Parse::FindHtml.find_title( entry )
        @date   = Parse::FindHtml.find_date( entry )
        @author = Parse::FindHtml.find_author( entry )
        msg     = Parse::FindHtml.find_content( entry )

        # perform information extraction using Open Amplify API
        @amplify.analyze( msg )

        # perform information extraction using Zemanta API
        @zemanta.analyze( msg )

        # perform information extraction using Open Calais API
        @calais.analyze( @title, @date, msg )

        # find related messages for this topic/title
        @html.analyze( entry )
      end

      def to_s
        puts "title => #{@title}, date => #{@date}, author => #{@author}"
        puts YamlHeader
        @amplify.to_s if @amplify && @amplify.doc
        puts YamlHeader
        @zemanta.to_s if @zemanta && @zemanta.doc
        puts YamlHeader
        @calais.to_s if @calais && @calais.doc
        puts YamlHeader
        @html.to_s if @html
      end
    end
  end
end
