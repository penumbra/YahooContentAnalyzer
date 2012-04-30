module Yahoo
  module Content
    module Parse
      begin
        prop = YAML::load_file( $ConfigFile )
        prop[ 'zemanta_xpath' ].each {|k, v| const_set( "#{k}", v ) }
      end

      class Zemanta
        class << self
          def parse_keywords( doc )
            doc.xpath( KeywordPath ).each do |node|
              yield node.text
            end
          rescue Exception => ex
            puts "Error parsing keywords => #{ex}"
          end
        end
      end # Zemanta Class

    end # Parse
  end # Content
end # Yahoo
