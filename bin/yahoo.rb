#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

require 'yahoo'
require 'limits'

# uses lib/yahoo.rb to read SynchronicityPhenomena group content
limits = Limits.new

yahoo_runner = YahooRunner.new( '/projects/yahoo/yahoo.yml' )

# 35 messages that were unavailable due to out (14342..14377)
limits.ids.each do |id|
  if id =~ /^28/
    yahoo_runner.process_message( id )
    sleep( 5 )
  end
end
