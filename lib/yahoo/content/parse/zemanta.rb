module Yahoo
  module Content
    module Parse
      class Zemanta
        class << self
          begin
            # set xpath = ... constants
            prop = YAML::load_file( $ConfigFile )
            prop[ 'zemanta_xpath' ].each { |key, value| const_set("#{key}", value) }
          end

          def parse_keywords( doc )
            doc.xpath( KeywordPath ).each do |node|
              yield node.text
            end
          rescue Exception => ex
            puts "Error parsing keywords => #{ex}"
          end
        end
      end
    end
  end
end