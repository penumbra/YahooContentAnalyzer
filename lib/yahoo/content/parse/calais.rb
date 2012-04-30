module Yahoo
  module Content
    module Parse
      begin
        prop = YAML::load_file( $ConfigFile )
        prop[ 'open_calais_xpath' ].each {|k, v| const_set( "#{k}", v ) }
      end

      class Calais
        class << self
          def parse( doc )
            show = false
            puts "doc => #{doc.to_s}" if show
          end
        end # self
      end # Calais

    end  # Parse
  end # Content
end  # Yahoo