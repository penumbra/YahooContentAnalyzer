#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

$ConfigFile = '/projects/YahooContentAnalyzer/yahoo.yml'

require 'yahoo'

tr = Yahoo::Topics::Runner.new

TopicsFile = 'topics.txt'

# process all message-####.html files anywhere within the data_path folder
tr.process_messages
tr.save_results( TopicsFile )
