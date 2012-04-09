#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

require 'yahoo'

ConfigFile = '/projects/yahoo/yahoo_secret.yml'
TopicsFile = '/projects/yahoo/data/topics.txt'

tr = Yahoo::Topics::Runner.new( ConfigFile )

tr.process_messages

f = File.open( TopicsFile, 'w' )

tr.topics.sort.each {|t| f.puts t }

f.close