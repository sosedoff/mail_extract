require 'strscan'

module MailExtract
  class Parser
    attr_reader :body
    
    # Initialize a new MailExtract::Parser object
    #
    # text - Email message body
    #
    def initialize(text)
      @lines     = []
      @text      = text.strip
      @body      = ""
      @last_type = :text
      @type      = :text
      parse
    end
    
    private
    
    # Process email message body
    #
    def parse
      scanner = StringScanner.new(@text)
      while str = scanner.scan_until(/\n/)
        parse_line(str)
      end
      if (last_line = scanner.rest.to_s).size > 0
        parse_line(last_line)
      end
      @body = @lines.join("\n").strip
    end
    
    # Process a single line
    #
    def parse_line(str)
      line = MailExtract::Line.new(str)
      if line.quote?
        if @last_type == :text      ; @type = :quote     ; end
      elsif line.text?
        if @last_type == :quote     ; @type = :text      ; end
        if @last_type == :signature ; @type = :signature ; end
      elsif line.signature?
        if @last_type == :text      ; @type = :signature ;
        elsif @last_type == :quote  ; @type = :quote     ; end
      end
      @last_type = line.type
      @lines << line.body.strip if @type == :text
    end
  end
end