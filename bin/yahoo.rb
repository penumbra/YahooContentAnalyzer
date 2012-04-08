#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

require 'yahoo'

# uses lib/yahoo.rb to read SynchronicityPhenomena group content
yahoo_runner = Yahoo::Runner.new( '/projects/yahoo/yahoo_secret.yml' )

# download 35 messages (14342..14377)
(14342..14343).each do |id|
  yahoo_runner.process_message( id )
end
