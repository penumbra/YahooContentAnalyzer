module Yahoo
  module Shared
    class AppConfig
      # data_path, output_path, save_group_path, do_reprocessing, reprocess_file, search_expr
      def config!( config_tag = 'application' )
        prop = YAML::load_file( $ConfigFile )
        prop[ config_tag ].each { |k, v| instance_variable_set("@#{k}", v) }
      end
    end
  end
end