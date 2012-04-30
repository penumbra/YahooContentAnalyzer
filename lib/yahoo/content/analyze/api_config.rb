module Yahoo
  module Content
    module Analyze

        class ApiConfig
          def config! (api_name )
            # api_key, host, port, path
            prop = YAML::load_file( $ConfigFile )
            prop[ api_name ].each { |k, v| instance_variable_set("@#{k}", v ) }
          end
        end # ApiConfig

    end # Analyze
  end # Content
end # Yahoo