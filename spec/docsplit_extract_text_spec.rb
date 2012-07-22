require 'spec_helper'

describe Paperclip::DocsplitText do
  before(:all) do
    @file = File.open("./fixtures/word_xml.docx")
  end

  after(:all) do
    @file.close
  end

  context "with no options supplied" do
    before(:all) do
      @options = {}
      @processor = Paperclip::DocsplitText.new(@file, @options)
    end

    it "#make sends the correct commands to Docsplit" do
      Docsplit.should_receive(:extract_text).with(File.expand_path(@file.path), @options.merge(:output => Dir.tmpdir))
  
      @processor.make
    end
    
    it "#make returns the full text of the document" do
      @processor.make.should eq("This is a test document.\n\n\f")
    end
  end

  context "with a destination column for extracted text" do
    it "#make stores the full text in the specified field" do
      pending
    end
  end

  context "when processing fails" do
    it "#make raises an error if the processing was unsuccessful" do
      Dir.stub!(:tmpdir).and_return(:raise)
    
      lambda {
        Paperclip::DocsplitText.new(@file, {}).make
      }.should raise_error(Paperclip::Error)
    end
  end
end