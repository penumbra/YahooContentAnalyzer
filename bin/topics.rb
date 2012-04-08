#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

require 'yahoo'

ConfigFile = '/projects/yahoo/yahoo_secret.yml'

tr = Yahoo::Topics::Runner.new( ConfigFile )

tr.process_data