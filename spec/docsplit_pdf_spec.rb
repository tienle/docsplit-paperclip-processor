require 'spec_helper'

describe Paperclip::DocsplitPdf do
  def make_output
    Paperclip::DocsplitPdf.new(@file).make
  end

  context "with a Microsoft Word .docx file" do
    before(:all) do
      @file = File.open("./fixtures/word_xml.docx")
      @output = make_output
    end

    after(:all) do
      @file.close
    end

    describe "produces a file with a .pdf extension" do
      it "names the converted document with a .pdf extension" do
        File.extname(@output.path).should eq(".pdf")
      end

      it "produces PDF-format file" do
        FileMagic.new.file(@output.path).should =~ /pdf/i
      end
    end
  end
  
  it "passes the document on if it is already a PDF" do
    @file = File.open("./fixtures/portable_document_format.pdf")

    lambda {
      FileMagic.new.file(make_output.path).should =~ /pdf/i
    }.should_not raise_error
    
    @file.close
  end

  it "raises an error if PDF conversion was unsuccessful" do
    @file = File.open("./fixtures/not_a_docx.docx")
    
    lambda {
      make_output
    }.should raise_error
    
    @file.close
  end

  describe "#pdf_format?" do
    it "identifies a PDF document as a PDF" do
      processor = Paperclip::DocsplitPdf.new(File.open("./fixtures/portable_document_format.pdf"))
      processor.pdf_format?.should be_true
    end

    it "identifies a non-PDF document as not a PDF" do
      processor = Paperclip::DocsplitPdf.new(File.open("./fixtures/word_xml.docx"))
      processor.pdf_format?.should be_false
    end
  end
end