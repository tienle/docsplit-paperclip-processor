require 'spec_helper'

describe Paperclip::DocsplitImage do
  context "with a valid pdf file attachment" do
    before(:all) do
      @file = File.open("./fixtures/nmfa-press-release-7-12-02.pdf")
      @processor = Paperclip::DocsplitImage.new(@file, {:format => :jpg})
      @output = @processor.make
    end
    
    after(:all) do
      @file.close
    end
    
    it "#make generates an image for each page of the document" do
      pending
    end
  
    it "#make generates images at the specified resolution" do
      pending
    end
  
    it "#make generates images in the specified format" do
      pending
    end
  
    it "#make returns the image of the first page" do
      pending
    end
  end
  
  context "with a bad file attachment" do
    it "#make raises an error if the processing was unsuccessful" do
      @file = File.open("./fixtures/not_a_docx.zip")
    
      lambda {
        Paperclip::DocsplitImage.new(@file, {:format => :jpg}).make
      }.should raise_error(Paperclip::Error)
    
      @file.close
    end
  end
end