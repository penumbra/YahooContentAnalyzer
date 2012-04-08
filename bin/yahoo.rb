#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

require 'yahoo'

# uses lib/yahoo.rb to read SynchronicityPhenomena group content
yahoo_runner = YahooRunner.new( '/projects/yahoo/yahoo.yml' )

# download 35 messages (14342..14377)
(14342..14377).each do |id|
  yahoo_runner.process_message( id )
  # wait 5 seconds so as to not cause a denial of service exception
  sleep( 5 )
end
