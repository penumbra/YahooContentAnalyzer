# Report an array of ID's for files listed in specified "reprocess file".
# This represents downloaded files that contain "unavailable" messages
#
# Note: the file was created by redirecting grep output as follows:
#   'grep "unavailable" * >reprocess.txt'
#
# Example Output:
# message-28001.html:The message you requested is temporarily unavailable because this group has exceeded its download limit.
# message-28001.html:The message you requested is temporarily unavailable because this group ...
#
module Yahoo
  module Groups
      module Parse
        class Reprocess
          attr_reader :ids

          def initialize( reprocess_fn )
            f = File.open( reprocess_fn )

            @ids = []
            f.lines.each do |line|
              val =  line[8..12]
              @ids << val
            end

            f.close
          end
        end
      end
  end
end