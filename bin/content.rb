#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

require 'yahoo'

ConfigFile = '/projects/YahooContentAnalyzer/yahoo.yml'

cr = Yahoo::Content::Runner.new( ConfigFile )

# process all message-####.html files anywhere within the data_path folder
cr.process_messages
