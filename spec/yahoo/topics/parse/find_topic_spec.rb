require 'spec_helper'

module Yahoo
  module Topics
    module Parse
      ExpectedResult = "Lucid Dreams synch"

      describe FindTopic do
        describe "#find" do
          it "should return a topic" do
            FindTopic.find( SampleHtml ).should == ExpectedResult
          end
        end
      end
    end
  end
end