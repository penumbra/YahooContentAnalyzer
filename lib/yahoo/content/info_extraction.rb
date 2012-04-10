module Yahoo
  module Content
    class InfoExtraction
      attr_reader :amplify
      attr_reader :content

      def initialize
        @content = Hash.new
        @amplify = Yahoo::Content::Amplify.new
      end

      def extract( id, msg )
        # add to a hash containing of all message content
        @content[id] = msg

        # perform information extraction using Open Amplify API
        @amplify.analyze_message( msg )

        report_amplify_results
      end

      def report_amplify_results
        @amplify.results.each do |result|
          result.each {|k,v| puts "#{k} [ #{v} ]"}
        end
      end
    end
  end
end
