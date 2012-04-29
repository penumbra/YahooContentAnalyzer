require 'rubygems'
require 'rspec'

$LOAD_PATH << File.expand_path('../../lib', __FILE__) << '.'

require 'yahoo'

BasePath = '/projects/YahooContentAnalyzer'
OutPath = File.join( BasePath, 'out' )
DataPath = File.join( BasePath, 'data' )

SampleHtml = File.join( OutPath, 'message-01296.html' )
Yahoo_Yml = File.join( BasePath, 'yahoo_secret.yml' )
