#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

$ConfigFile = '/projects/YahooContentAnalyzer/yahoo.yml'

require 'yahoo'

cr = Yahoo::Content::Runner.new

# process all message-####.html files anywhere within the data_path folder
cr.process_messages
