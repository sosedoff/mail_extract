require 'mail_extract/line'
require 'mail_extract/parser'

module MailExtract
  class << self
    # Shortcut to MailExtract::Parser.new
    #
    # body    - Email message contents
    # options - Parser options
    #
    # @return [MailExtract::Parser]
    #
    def new(body, options={})
      MailExtract::Parser.new(body, options)
    end
    
    # Parse the email message
    #
    # body    - Email message contents
    # options - Parser options
    #
    # @return [String]
    #
    def parse(body, options={})
      MailExtract::Parser.new(body, options).body
    end
  end
end
