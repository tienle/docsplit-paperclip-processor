require "docsplit"
require "paperclip"
require "filemagic"

module Paperclip
  class DocsplitProcessor < Processor
    attr_accessor :src, :options, :attachment

    def initialize(file, options = {}, attachment = nil)
      super
      @src        = file
      @options    = options
      @attachment = attachment
      @basename   = File.basename(@file.path, '.*')
    end
    
    def src_path
      File.expand_path(@src.path)
    end
  end
end

require 'processors/docsplit_image'
require 'processors/docsplit_pdf'
require 'processors/docsplit_text'