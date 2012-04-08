require 'rubygems'
require 'yaml'

module Yahoo
  # usage:
  #   yr = Yahoo::Runner( my_yaml_file )
  #   (1..10000).each {|id| yr.process_message( id ) }
  #
  # also:
  #   details on how to activate the reprocessing feature may be
  #   found in parse_reprocess.rb
  class Runner
    # wait 5 seconds so as to not cause a denial of service exception
    WaitSeconds = 5
    # Tag used in YAML file to identify the Yahoo configuration block
    YahooConfigTag = 'yahoo'

    def initialize( yahoo_yml )
      prop = YAML::load_file( yahoo_yml )

      # create instance variables from the yahoo: group properties
      prop[YahooConfigTag].each { |key, value| instance_variable_set("@#{key}", value) }

      # use YahooGroups class to login to Yahoo
      @yahoo = Yahoo::Groups.new( @login_id, @password )

      # open the main page of the user-specified group
      html = @yahoo.select_group( @group_name )

      if @save_group_page
        fn = File::join(@data_path, @group_name)
        Yahoo::FileUtils::write_file( fn, html ) unless html == nil
      end

      # create the data folder unless it already exits
      Yahoo::FileUtils::make_data_dir( @data_path )

      # do reprocessing (file content failed to download due to Yahoo Group limitations)
      reprocess_messages unless @do_reprocessing == false
    end

    # reprocess html files that were 'unavailable' due to group limits having been reached
    def reprocess_messages
      reproc = Yahoo::ParseReprocess.new( @reprocess_file )

      reproc.ids.each do |id|
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