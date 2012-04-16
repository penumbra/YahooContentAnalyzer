#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

require 'yahoo'

ConfigFile = '/projects/yahoo/yahoo.yml'
TopicsFile = 'topics.txt'

tr = Yahoo::Topics::Runner.new( ConfigFile )

# process all message-####.html files anywhere within the data_path folder
tr.process_messages
tr.save_results( TopicsFile )
