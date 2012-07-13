require 'spec_helper'

describe Paperclip::DocsplitImage do
  def pdf_jpg_images
    Dir.entries(Dir.tmpdir).reject{ |x| !(x =~ /twopage_\d.jpg/) }
  end
  
  context "with a valid pdf file attachment" do
    before(:all) do
      pdf_jpg_images.each do |tempfile|
        File.delete(File.join(Dir.tmpdir, tempfile))
      end
      
      @file = File.open("./fixtures/twopage.pdf")
      @processor = Paperclip::DocsplitImage.new(@file, {:format => :jpg, :size => "50x50"})
      @output = @processor.make
    end
    
    after(:all) do
      @file.close
    end
    
    it "#make generates an image for each page of the document" do
      pdf_jpg_images.count.should eq(2)
    end
  
    it "#make generates images at the specified resolution" do
      cmd = %Q[identify -format "%wx%h" "#{@output.path}"]
      `#{cmd}`.chomp.should eq("39x50")
    end
  
    it "#make generates images in the specified format" do
      pdf_jpg_images.each do |output_file|
        FileMagic.new.file(File.join(Dir.tmpdir, output_file)).should =~ /jpeg/i
      end
    end
  
    it "#make returns the image of the first page" do
      File.basename(@output).should eq('twopage_1.jpg')
    end
  end
  
  context "when processing fails" do
    it "#make raises an error if the processing was unsuccessful" do
      @file = File.open("./fixtures/twopage.pdf")
      Dir.stub!(:tmpdir).and_return(:raise)
    
      lambda {
        Paperclip::DocsplitImage.new(@file, {:format => :jpg}).make
      }.should raise_error(Paperclip::Error)
    
      @file.close
    end
  end
end