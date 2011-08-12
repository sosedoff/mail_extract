require 'strscan'

module MailExtract
  class Parser
    attr_reader :body
    
    # Initialize a new MailExtract::Parser object
    #
    # text    - Email message body
    # options - Parsing options
    #
    # Parsing options include:
    #   :only_head - Skip the rest of the message after quote start (default: false)
    #
    def initialize(text, options={})
      @lines     = []
      @text      = text.strip
      @body      = ""
      @last_type = :text
      @type      = :text
      @options   = options
      
      parse
    end
    
    private
    
    # Process email message body
    #
    def parse
      break_after_quote = @options[:only_head] || false
      scanner = StringScanner.new(@text)
      
      # Process until message end
      while str = scanner.scan_until(/\n/)
        line = parse_line(str)
        
        if break_after_quote
          break if line.quote? && line.subtype == :start
        end
      end
      
      # Process the rest (if any)
      if !break_after_quote && @last_type != :quote
        if (last_line = scanner.rest.to_s).size > 0
          parse_line(last_line)
        end
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
      
      line
    end
  end
end