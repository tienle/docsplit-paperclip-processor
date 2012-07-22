require 'spec_helper'

describe Paperclip::DocsplitExtractText do
  before(:all) do
    @file = File.open("./fixtures/word_xml.docx")
    @options = {}
    @processor = Paperclip::DocsplitExtractText.new(File.open("./fixtures/word_xml.docx"), @options)
  end

  after(:all) do
    @file.close
  end

  it "#make sends the correct commands to Docsplit" do
    Docsplit.should_receive(:extract_text).with(File.expand_path(@file.path), @options.merge(:output => Dir.tmpdir))

    @processor.make
  end
    
  it "#make returns the full text of the document" do
    @processor.make.should eq("This is a test document.\n\n\f")
  end

  context "when processing fails" do
    it "#make raises an error if the processing was unsuccessful" do
      Dir.stub!(:tmpdir).and_return(:raise)
    
      lambda {
        @processor.make
      }.should raise_error(Paperclip::Error)
    end
  end
end