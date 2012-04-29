#!/usr/bin/env /projects/rubinius-1.2.4/bin/ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

$ConfigFile = '/projects/YahooContentAnalyzer/yahoo.yml'

require 'yahoo'

# uses lib/yahoo.rb to read SynchronicityPhenomena group content
yahoo_runner = Yahoo::Groups::Runner.new
#
# Warning: This program does not  yet prevent processing
#  a message id range where the upper range exceed the
#  total number of messages in a Yahoo Group Forum.
#

# download 1,000 messages from my favorite Yahoo Newsgroup
(32001..32010).each { |id| yahoo_runner.process_message( id ) }
