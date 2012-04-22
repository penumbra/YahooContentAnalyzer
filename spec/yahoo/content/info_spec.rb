require 'spec_helper'

module Yahoo
  module Content
    describe Info do
      let(:info) do
         info = Info.new( Yahoo_Yml  )
      end

      let (:msg) do
        # use the Content::Finder to locate the message body
        msg = Parse::FindContent.find( SampleHtml )
      end

      describe "#analyze" do
        it "should have a top topic of dream with a weight of 20.00" do
          info.analyze( msg )

          Parse::Amplify::parse_topics( info.amplify.doc ) do |tn, wt, vals|
            tn.should == "dream"
            wt.should == "20.00"
            break
          end
        end

        it "should list keywords" do
          info.analyze( msg )

          Parse::Zemanta::parse_keywords( info.zemanta.doc ) do |kw|
            kw.should == 'Lucid dream'
            break
          end
        end
      end
    end
  end
end
