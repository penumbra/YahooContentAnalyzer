require 'spec_helper'

module Yahoo
  module Content
    module Parse
      describe FindHtml do
        Title = 'Lucid Dreams synch'
        Date = '2002-2-11T16:26:25Z'
        Author = 'Don Boulet'

        describe "#find_title" do
          it "should return a topic title" do
            FindHtml.find_title( SampleHtml ).should == Title
          end

          it "should return a specific date" do
            FindHtml.find_date( SampleHtml ).should == Date
          end

          it "should return a specific author" do
            FindHtml.find_author( SampleHtml ).should == Author
          end
        end
      end
    end
  end
end