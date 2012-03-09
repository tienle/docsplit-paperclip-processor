# Ruby on Rails 3 Paperclip Docsplit Processor #

This gem is Paperclip processor, utilizing Docsplit in order to convert uploaded files to pdf and extract information/thumbnails.
These include the Microsoft Office formats: doc, docx, ppt, xls and so on, as well as html, odf, rtf, swf, svg, and wpd.

## Requirements ##

* [Paperclip][0]
* [Docsplit][1]

## Installation ##

(This gem is written and tested on Ruby 1.9 and Rails 3 only).

In order to install it, add to your Gemfile:

    gem 'docsplit-paperclip-processor'

And then run:

    bundle install


## Using Processor ##

Use it as you would any other Paperclip processor. For example, in your model:

    class Document < ActiveRecord::Base

      has_attached_file :file,
                        :styles => {
                          :pdf => {
                            :format => "pdf",
                            :processors => [:docsplit_pdf]
                          }
                        }

    end


which will convert your document into pdf.

### Extract information (text, metadata) and thumbnail ###

Will be include in the next releases.

## Release info ##

Be warned, this gem is released as early beta version.
If you are using it you are doing so on your own responsibility.

Have fun with it and drop me a note if you like it.


[0]: https://github.com/thoughtbot/paperclip
[1]: http://documentcloud.github.com/docsplit/
