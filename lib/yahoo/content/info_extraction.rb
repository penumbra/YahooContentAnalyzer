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
        results = @amplify.results

        results.each do |topic_name, values|
          puts "topic => #{topic_name}, entity count #{values.size - 1}, weight => #{get_weight( values )}"
        end
      end

      def get_weight( values )
        wt = nil

        values.each do |value|
          if value[:weight]
            wt = value[:weight]
          end
        end

        wt
      end
    end
  end
end