module Paperclip
  class DocsplitText < DocsplitProcessor
    def make
      begin
        @dst_path = Dir.tmpdir
        @pages    = @options[:pages] || [1]
        @options  = @options.merge(:output => @dst_path)

        Docsplit.extract_text(src_path, @options)
      rescue Exception => e
        raise Paperclip::Error, "There was an error extracting text from #{@basename}"
      end

      if @options[:full_text_column]
        # Bypassing callbacks to save full text. See Paperclip issue #671:
        # https://github.com/thoughtbot/paperclip/issues/671
        ar_model = @attachment.instance
        ar_model[@options[:full_text_column]] = full_text
        ar_model.run_callbacks(:save) { false }

        # This would be the preferred method of saving this text.
        # @attachment.instance.update_attribute(@options[:full_text_column], full_text)
      end

      destination_file
    end

    def destination_file
      File.open(File.join(@dst_path, "#{@basename}.txt"))
    end

    def full_text
      full_text = String.new

      destination_file.each do |line|
        full_text += line
      end

      full_text
    end
  end
end