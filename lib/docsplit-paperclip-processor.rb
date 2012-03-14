require "paperclip"
module Paperclip
  class DocsplitProcessor < Processor
    attr_accessor :src, :options

    def initialize(file, options = {}, attachment = nil)
      super
      @src      = file
      @options  = options
      @basename = File.basename(@file.path, '.*')
    end
  end

  class DocsplitChaining < Processor
    attr_accessor :options, :attachment

    def initialize(file, options = {}, attachment = nil)
      @options    = options
      @attachment = attachment
    end

    def make
      attachment.to_file(options[:from_style] || :original)
    end
  end

  class DocsplitPdf < DocsplitProcessor
    def make
      begin
        src_path = File.expand_path(@src.path)
        dst_path = Dir.tmpdir

        Docsplit.extract_pdf(src_path, :output => dst_path)
      rescue Exception => e
        Rails.logger.error e.message
        raise PaperclipError, "There was an error converting #{basename} to pdf"
      end
      File.open(File.join(dst_path, "#{@basename}.pdf"))
    end
  end

  class DocsplitImage < DocsplitProcessor
    def make
      begin
        src_path = File.expand_path(@src.path)
        dst_path = Dir.tmpdir
        pages    = options[:pages] || [1]
        options  = @options.merge(:output => dst_path)

        Docsplit.extract_images(src_path, options)
      rescue Exception => e
        Rails.logger.error e.message
        raise PaperclipError, "There was an error extracting images from #{basename}"
      end
      File.open(File.join(dst_path, "#{@basename}_#{pages.first}.#{@options[:format]}"))
    end
  end
end
