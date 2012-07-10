require 'spec_helper'

describe Paperclip::DocsplitProcessor do
  it "has an accessible file attribute" do
    d = Paperclip::DocsplitProcessor.new(File.open("./fixtures/word_xml.docx"))
    d.src.path.should eq(File.open("./fixtures/word_xml.docx").path)
  end
  
  it "has an accessible options hash attribute" do
    options = {:option_1 => 1, :option_2 => 2}
    d = Paperclip::DocsplitProcessor.new(File.open("./fixtures/word_xml.docx"), options)
    d.options.should eq(options)
  end
  
  it "has an accessible Paperclip::Attachment attribute" do
    attachment = Paperclip::Attachment.new(nil, nil)
    
    d = Paperclip::DocsplitProcessor.new(File.open("./fixtures/word_xml.docx"), {}, attachment)
    d.attachment.should eq(attachment)
  end
end