require 'mail_extract/line'
require 'mail_extract/parser'

module MailExtract
  class << self
    # Shortcut to MailExtract::Parser.new
    #
    def new(body)
      MailExtract::Parser.new(body)
    end
  end
end
