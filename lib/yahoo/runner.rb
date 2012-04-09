module Yahoo
  class Runner
    # Tag used in YAML file to identify the Yahoo configuration block
    YahooConfigTag = 'yahoo'

    def initialize( yahoo_yml )
      prop = YAML::load_file( yahoo_yml )

      # create instance variables from the yahoo: group properties
      prop[YahooConfigTag].each { |key, value| instance_variable_set("@#{key}", value) }
    end
  end
end