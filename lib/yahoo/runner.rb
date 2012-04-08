require 'rubygems'
require 'yaml'
require 'fileutils'

# uses lib/yahoo.rb to read group content specified by yahoo.yml
class YahooRunner
  YahooConfigTag = 'yahoo'

  def initialize( yahoo_yml )
    prop = YAML::load_file( yahoo_yml )

    # create instance variables from the yahoo: group properties
    prop[YahooConfigTag].each { |key, value| instance_variable_set("@#{key}", value) }

    # use YahooGroups class to login to Yahoo
    @yahoo = YahooGroups.new( @login_id, @password )

    # open the main page of the user-specified group
    html = @yahoo.select_group( @group_name )

    if @save_group_page
      fn = File::join(@data_path, @group_name)
      Browse::Helper::save( fn, html ) unless html == nil
    end

    # create the data folder unless it already exits
    make_data_dir

    # do reprocessing (file content failed to download due to Yahoo Group limitations)
    reprocess unless @do_reprocessing == false
  end

  #
  # reprocess html files that were 'unavailable' due to group limits having been reached
  #
  def reprocess
    require 'reprocess'
    reproc = Reprocess.new( @reprocess_file )

    reproc.ids.each do |id|
      process_message( id )
      sleep( 5 )
    end
  end

  # use YahooGroups to read then save a message from a Yahoo Group
  def process_message( id )
    html = @yahoo.get_message(id)

    if html != nil
      fn = get_filename( id )
      puts "writing #{fn}..."
      Browse::Helper::save( fn, html )
    end
  end

  def get_filename( id )
    fn = File::join(@data_path, 'message')
    fn = format("#{fn}-%05d.html", id)
  end

  def make_data_dir
    FileUtils::mkdir( @data_path )
  rescue
    # already exists
  end
end
