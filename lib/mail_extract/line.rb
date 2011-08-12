module MailExtract
  class Line
    attr_reader :body, :type, :subtype
    
    PATTERNS = {
      /^[>]+\s?/                     => :quote,
      /^--/                          => :signature,
      /^-- /                         => :signature,
      /^[_]{2,}\n?/                  => :signature,
      /^[-]{2,}\n?/                  => :signature,
      /^sent from my (iphone|ipad)/i => :signature 
    }
    
    def initialize(str)
      @body    = str
      @subtype = :none
      
      detect_type(str)
    end
    
    # Returns true if line was detected as text
    #
    def text?
      type == :text
    end
    
    # Returns true if line was detected as quote
    #
    def quote?
      type == :quote
    end
    
    # Returns true if line was detected as signature
    #
    def signature?
      type == :signature
    end
    
    private
    
    def detect_type(line)
      # Detects the start line of quote text
      if line.strip =~ /^On\s/i && line =~ /at [\d:]+/ || line.strip =~ />? wrote:\z/
        @type    = :quote
        @subtype = :start
        return
      end
      
      @type = :text
      
      PATTERNS.each_pair do |p,t|
        if line =~ p
          @type = t
          break
        end
      end
    end
  end
end
