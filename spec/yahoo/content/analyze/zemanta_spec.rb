require 'spec_helper'

module Yahoo
  module Content
    module Analyze
      describe Zemanta do

        let(:zemanta) do
          zemanta = Zemanta.new
        end

        let(:msg) do
          msg = Yahoo::Content::Parse::FindHtml.find_content( SampleHtml )
        end

        it "should list keywords" do
          zemanta.analyze( msg )

          Parse::Zemanta::parse_keywords( zemanta.doc ) do |kw|
            kw.should == 'Lucid dream'
            break
          end
        end
      end
    end
  end
end