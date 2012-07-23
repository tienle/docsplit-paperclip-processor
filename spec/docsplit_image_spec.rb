require 'spec_helper'

describe Paperclip::DocsplitImage do
  def delete_temp_images
    Dir.entries(Dir.tmpdir).reject{ |x| !(x =~ /twopage_\d.jpg/) }.each do |tempfile|
      File.delete(File.join(Dir.tmpdir, tempfile))
    end
  end

  before(:all) do
    delete_temp_images
    @file = File.open("./fixtures/twopage.pdf")
  end

  after(:all) do
    delete_temp_images
    @file.close
  end
  
  context "with a valid pdf file attachment" do
    before(:all) do
      @options = {:format => :jpg, :size => "50x50"}
      @processor = Paperclip::DocsplitImage.new(@file, @options)
    end
    
    it "#make sends the correct commands to Docsplit" do
      @processor.stub!(:destination_file)
      Docsplit.should_receive(:extract_images).with(File.expand_path(@file.path), @options.merge(:output => Dir.tmpdir))

      @processor.make
    end
    
    it "#make returns the image of the first page" do
      @processor.make.path.should eq(File.open(Dir.tmpdir + '/twopage_1.jpg').path)
    end
  end
  
  context "when processing fails" do
    it "#make raises an error if the processing was unsuccessful" do
      Dir.stub!(:tmpdir).and_return(:raise)
    
      lambda {
        Paperclip::DocsplitImage.new(@file, {:format => :jpg}).make
      }.should raise_error(Paperclip::Error)
    end
  end
end