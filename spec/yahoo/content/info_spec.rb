require 'rspec'
require 'yahoo'

module Yahoo
  module Content
    describe Info do
      let(:info) do
         info = Info.new( Yahoo_Yml )
      end

      let (:msg) do
        # use the Content::Finder to locate the message body
        msg = Parse::FindContent.find( SampleHtml )
      end

      describe "#extract" do
        it "should have a top topic of dream with a weight of 20.00" do
          doc = info.extract( SampleId, msg, false )

          Parse::Amplify::parse( Parse::Amplify::top_topics( doc ) ) do |tn, wt, vals|
            tn.should == "dream"
            wt.should == "20.00"
            break
          end
        end
      end
    end
  end
end
