require 'mail_extract/line'
require 'mail_extract/parser'

module MailExtract
  class << self
    # Shortcut to MailExtract::Parser.new
    #
    # @return [MailExtract::Parser]
    #
    def new(body, options={})
      MailExtract::Parser.new(body, options)
    end
  end
end
