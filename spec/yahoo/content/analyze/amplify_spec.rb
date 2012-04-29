require 'spec_helper'

module Yahoo
  module Content
    module Analyze
      describe Amplify do
        let (:amplify) do
          amplify = Amplify.new
        end

        let(:html) do
          html = Yahoo::Content::Analyze::Html.new
          html.analyze( SampleHtml )
          html
        end

        it "should have a top topic of dream with a weight of 20.00" do
          amplify.analyze( html )

          Parse::Amplify::parse_topics( amplify.doc ) do |tn, wt, vals|
            tn.should == "dream"
            wt.should == "20.00"
            break
          end
        end
      end
    end
  end
end

