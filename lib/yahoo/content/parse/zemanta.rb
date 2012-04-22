module Yahoo
  module Content
    module Parse
      class Zemanta
        KeywordPath = '//keywords/keyword/name'

        class << self
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