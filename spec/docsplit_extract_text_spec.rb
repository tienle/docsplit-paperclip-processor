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
    
    it "#make returns the text tempfile created by Docsplit" do
      result = @processor.make

      text = String.new
      result.each do |line|
        text += line
      end

      text.should eq("This is a test document.\n\n\f")
    end
  end

  context "with a destination column for extracted text" do
    before(:all) do
      @options = {:full_text_column => :document_full_text}
      @doc = Document.new()
    end

    after(:all) do
      FileUtils.rm_rf("./spec/tmp", secure: true)
    end

    it "#make stores the full text in the specified field" do
      @doc.original = @file
      @doc.save!

      @doc.reload

      @doc.original_full_text.should eq("This is a test document.\n\n\f")
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