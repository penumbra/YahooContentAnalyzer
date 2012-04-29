require 'spec_helper'

module Yahoo
  module Content
    module Analyze
      describe Zemanta do

        let(:zemanta) do
          zemanta = Zemanta.new
        end

        let(:html) do
          html = Yahoo::Content::Analyze::Html.new
          html.analyze( SampleHtml )
          html
        end

        it "should list keywords" do
          zemanta.analyze( html )

          Parse::Zemanta::parse_keywords( zemanta.doc ) do |kw|
            kw.should == 'Lucid dream'
            break
          end
        end
      end
    end
  end
end