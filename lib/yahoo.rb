require 'rubygems'
require 'mechanize'
require 'yaml'

# browse web as Mechanized client
require 'browse'

# shared by several modules
require 'yahoo/shared/config'
require 'yahoo/shared/finder'
require 'yahoo/shared/file_utils'

# browse messages in Yahoo Newsgroup
require 'yahoo/groups/login'
require 'yahoo/groups/reader'
require 'yahoo/groups/parse/reprocess'
require 'yahoo/groups/runner'

# scan messages for topics
require 'yahoo/topics/parse/find_topic'
require 'yahoo/topics/runner'

# parse the message content
require 'yahoo/content/parse/find_content'
require 'yahoo/content/parse/find_links'
require 'yahoo/content/parse/amplify'
require 'yahoo/content/parse/zemanta'

# analyze the message content
require 'yahoo/content/zemanta'
require 'yahoo/content/amplify'
require 'yahoo/content/info'
require 'yahoo/content/runner'

