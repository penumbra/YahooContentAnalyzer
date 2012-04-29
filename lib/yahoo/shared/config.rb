module Yahoo
  module Shared
    class Config
      # Tag used in@ YAML file to identify the Yahoo configuration block
      YahooConfigTag = 'yahoo'
      AppConfigTag   = 'application'
      OpenAmplifyTag = 'open_amplify'
      OpenCalaisTag  = 'open_calais'
      ZemantaTag     = 'zemanta'
      AlchemyTag     = 'alchemy'

      def initialize( yahoo_yml )
        @prop = YAML::load_file( yahoo_yml )
      end

      # create instance variables from the yahoo: group properties
      def add_properties!( tag )
        @prop[ tag ].each { |key, value| instance_variable_set("@#{key}", value) }
      end
    end
  end
end