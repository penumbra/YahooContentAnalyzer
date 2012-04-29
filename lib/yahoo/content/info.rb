module Yahoo
  module Content
    class Info
      YamlHeader = "---"

      def initialize
        @html    = Analyze::Html.new

        @ie = [Analyze::Amplify.new, Analyze::Calais.new, Analyze::Zemanta.new, Analyze::Alchemy.new]
      end

      def analyze( entry )
        # extract title, msg, date, author, and linked messages
        @html.analyze( entry )

        # perform information extraction
        @ie.each {|extractor| extractor.analyze( @html ) }
      end

      def to_s
        puts YamlHeader
        @html.to_s if @html

        @ie.each {|extractor| extractor.to_s if extractor.doc }
      end
    end
  end
end
