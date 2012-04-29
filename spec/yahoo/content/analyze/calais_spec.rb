require 'spec_helper'

module Yahoo
  module Content
    module Analyze
      describe Calais do
        Person = 'Stephen LeBerge, Ph.D.'

        let(:calais) do
          calais = Calais.new
        end

        let(:html) do
          html = Yahoo::Content::Analyze::Html.new
          html.analyze( SampleHtml )
          html
        end

        it "should create an xml/rdf report" do
          calais.analyze( html )

          test_match( calais.doc ).should == true
        end

        def test_match( doc )
          puts doc.to_s

          doc.xpath('//c:exact').each do |node|
            if node.text == Person
              return true
            end
          end

          false
        end
      end
    end
  end
end