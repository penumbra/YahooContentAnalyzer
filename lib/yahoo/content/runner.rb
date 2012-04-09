module Yahoo
  module Content
    class Runner < Yahoo::Runner
      # File search path expression to find downloaded html files across folders
      SearchExpression = '**/message-*.html'

      attr_reader :content

      def initialize( yahoo_yml )
        super( yahoo_yml )
        @content = Hash.new
      end

      # find the message-#####.html files and add the topic name to @topics
      def process_messages
        html_search = File.join( @data_path, SearchExpression )
        entries = Dir.glob( html_search )

        entries.sort.each do |entry|
          msg_id = get_id( entry )
          puts "processing #{msg_id}"

          message = Yahoo::Content::ContentFinder.find_message( entry )

          # console io
          puts "msg_id => #{msg_id} content => #{message}"

          @content.merge!( {:message_id => msg_id, :content => message } )
        end
      end

      def get_id( entry )
        idx = entry =~ /message-[0-9]/
        max = entry.size - 1

        entry[idx..max]
      end
    end
  end
end