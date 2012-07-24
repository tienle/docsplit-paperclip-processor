module Paperclip
  class DocsplitImage < DocsplitProcessor
    def make
      begin
        @dst_path = Dir.tmpdir
        @pages    = @options[:pages] || [1]
        @options  = @options.merge(:output => @dst_path)

        Docsplit.extract_images(src_path, @options)
      rescue Exception => e
        raise Paperclip::Error, "There was an error extracting images from #{@basename}"
      end
      
      destination_file
    end

    def destination_file
      File.open(File.join(@dst_path, "#{@basename}_#{@pages.first}.#{@options[:format]}"))
    end
  end
end