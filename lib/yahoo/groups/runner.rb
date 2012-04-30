require 'rubygems'
require 'yaml'

module Yahoo
  module Groups

    class Runner < Yahoo::Shared::AppConfig
      # wait 5 seconds so as to not cause a denial of service exception
      WaitSeconds = 5

      def initialize
        config! # data path, output path, etc

        # use Yahoo::Groups::Login class to login to Yahoo
        @yahoo = Yahoo::Groups::Reader.new

        # open the main page of the user-specified group
        html = @yahoo.select_group

        # create the data folder unless it already exits
        Yahoo::Shared::FileUtils::make_data_dir( @data_path )

        if @save_group_page
          fn = File::join(@data_path, @group_name)
          Yahoo::Shared::FileUtils::write_file( fn, html ) unless html == nil
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
          fn = Yahoo::Shared::FileUtils::format_filename( @data_path, id )
          Yahoo::Shared::FileUtils::write_file( fn, html )
        end

        sleep( WaitSeconds )
      end
    end # Runner

  end # Groups
end # Yahoo
