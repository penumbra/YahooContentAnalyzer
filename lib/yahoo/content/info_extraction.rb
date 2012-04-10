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

        results.each do |k, v|
          wt = 0.0
          v.each do |h|
            if h[:weight]
              wt = h[:weight]
            end
          end
          puts "topic => #{k}, entity count #{v.size - 1}, weight => #{wt}"
          v.each do |h|
            if not h[:weight]
              h.each {|k,v| puts "  #{k}->#{v}"}
            end
          end
        end
      end
    end
  end
end
