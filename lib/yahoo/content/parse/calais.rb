module Yahoo
  module Content
    module Parse

      class Calais
        class << self
          def parse( doc )
            puts "doc => #{doc.to_s}"
          end
        end # self
      end # Calais
    end
  end
end