require "paperclip"
module Paperclip
  class DocsplitPdf < Processor

    attr_accessor :src, :options

    def initialize(file, options = {}, attachment = nil)
      super
      @src      = file
      @options  = options
      @basename = File.basename(@file.path, '.*')
    end

    def make
      begin
        src_path = File.expand_path(@src.path)
        dst_path = Dir.tmpdir
        escaped_src, escaped_dst = [src_path, dst_path].map &Docsplit::ESCAPE

        Docsplit.extract_pdf(escaped_src, :output => escaped_dst)
      rescue Cocaine::CommandLineError => e
        Rails.logger.error e.message
        raise PaperclipError, "There was an error converting #{basename} to pdf"
      end
      File.open(File.join(dst_path, "#{@basename}.pdf"))
    end
  end
end
