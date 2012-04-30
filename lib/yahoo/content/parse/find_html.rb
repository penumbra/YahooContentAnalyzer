require 'rubygems'
require 'set'
require 'nokogiri'

module Yahoo
  module Content
    module Parse
      begin
        prop = YAML::load_file( $ConfigFile )
        prop[ 'yahoo_html_xpath' ].each {|k, v| const_set( "#{k}", v ) }
      end

      # located an element by xpath within a specified HTML document
      class FindHtml
        class << self
          include Yahoo::Shared::Finder

          def find_topic( fn, xpath = Parse::GroupTopicXPath )
            node = find( fn, xpath )
            node.text
          end

          def find_date( fn, xpath = Parse::GroupDateXPath )
            node = find( fn, xpath )
            # title attribute
            node[0]['title'].chomp
          end

          def find_author( fn, xpath = Parse::GroupAuthorXPath )
            node = find( fn, xpath )

            idx = (node.text =~ /\</)
            if idx 
              node.text[0..idx-2]
            else
              nil
            end
          end

          def find_content( fn, xpath = Parse::MessageXPath )
            node = find( fn, xpath )
            node.text
          end

          def find_links( fn, xpath = Parse::MessageLinksXPath )
            node_list = find( fn, xpath )

            # return an array of id's representing other messages in the newsgroup thread
            get_ids( node_list )
          end

          # compile an array of related message id's
          def get_ids( node_list )
            ids = []

            if node_list != nil
              node_list.each do |node|
                id = get_id( node['href'] )

                ids << id.to_i unless id == nil
              end
            end

            ids
          end

          # use regex to extract the message id from a URL
          def get_id( href )
            if href =~ /p=[0-9]*$/
              href =~ /(message\/\d*)/
              match = $~

              match.string[match.begin(0)+"message/".size .. match.end(0)-1]
            else
              nil
            end
          end
        end # self
      end # FindHtml

    end # Parse
  end # Content
end # Yahoo
