require 'rubygems'
require 'yaml'

module Yahoo
  module Groups
    # example usage:
    #   yr = Yahoo::Runner( my_yaml_file )
    #   (1..10000).each {|id| yr.process_message( id ) }
    #
    # also:
    #   details on how to activate the reprocessing feature may be
    #   found in parse_reprocess.rb
    class Runner < Yahoo::Runner
      # wait 5 seconds so as to not cause a denial of service exception
      WaitSeconds = 5

      def initialize( yahoo_yml )
        super( yahoo_yml )

        # use YahooGroups class to login to Yahoo
        @yahoo = Yahoo::Groups::Reader.new( @login_id, @password )

        # open the main page of the user-specified group
        html = @yahoo.select_group( @group_name )

        # create the data folder unless it already exits
        Yahoo::FileUtils::make_data_dir( @data_path )

        if @save_group_page
          fn = File::join(@data_path, @group_name)
          Yahoo::FileUtils::write_file( fn, html ) unless html == nil
        end

        # do reprocessing (file content failed to download due to Yahoo Group limitations)
        reprocess_messages unless @do_reprocessing == false
      end

      # reprocess html files that were 'unavailable' due to group limits having been reached
      def reprocess_messages
        fn = File::join(@data_path, @reprocess_file )
        Parse::Reprocess.new( fn ).ids.each do  |id|
          process_message( id )
        end
      end

      # use YahooGroups to read then save a message from a Yahoo Group
      def process_message( id )
        html = @yahoo.get_message(id)

        if html != nil
          fn = Yahoo::FileUtils::format_filename( @data_path, id )
          Yahoo::FileUtils::write_file( fn, html )
        end

        sleep( WaitSeconds )
      end
    end
  end
end