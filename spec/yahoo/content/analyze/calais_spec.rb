require 'spec_helper'

module Yahoo
  module Content
    module Analyze
      describe Calais do
        Person = 'Stephen LeBerge, Ph.D.'

        let(:calais) do
          calais = Calais.new
        end

        let(:msg) do
          msg = Parse::FindHtml.find_content( SampleHtml )
        end

        let(:title) do
          title = Parse::FindHtml.find_title( SampleHtml )
        end

        let (:date) do
          date = Parse::FindHtml.find_date( SampleHtml )
        end

        it "should create an xml/rdf report" do
          calais.analyze( title, date, msg )

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