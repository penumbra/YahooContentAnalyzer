#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

require 'yahoo'

# uses lib/yahoo.rb to read SynchronicityPhenomena group content
yahoo_runner = Yahoo::Runner.new( '/projects/yahoo/yahoo.yml' )

# download 1,000 messages from my favorite Yahoo Newsgroup
(1..1000).each { |id| yahoo_runner.process_message( id ) }
