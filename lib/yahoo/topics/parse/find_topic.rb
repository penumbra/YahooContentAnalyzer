require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Topics
    module Parse
      # locate a specific element by xpath within the specified HTML document
      class FindTopic < Yahoo::Shared::Finder
        class << self
          begin
            # set xpath = ... constants
            prop = YAML::load_file( $ConfigFile )
            prop[ 'yahoo_html_xpath' ].each { |key, value| const_set("#{key}", value) }
          end

          def find( fn, xpath = GroupTopicXPath )
            node = super( fn, xpath )

            node.text if node
          end
        end # self
      end # FindTopic
    end #  Parse
  end  # Topics
end  # Yahoo
