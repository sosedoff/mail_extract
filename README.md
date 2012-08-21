# MailExtract

MailExtract is a small ruby library to parse plain-text email contents.

It removes all quoted text and signatures leaving only original text. 

## Installation

    gem install mail_extract

## Usage

### General usage

```ruby
require 'mail_extract'

body = MailExtract::Parser.new('MESSAGE').body

# or via shortcut
body = MailExtract.new('MESSAGE').body

# or via another shortcut
body = MailExtract.parse('MESSAGE')
```

### Using with Mail gem

```ruby
require 'mail'
require 'mail_extract'

mail = Mail.read_from_string(YOUR_MESSAGE_BODY)

# find only plain-text parts
if mail.multipart?
  part = mail.parts.select { |p| p.content_type =~ /text\/plain/ }.first rescue nil
  unless part.nil?
    message = part.body.decoded
  end
else
  message = mail.body.decoded
end

clean_message = MailExtract.new(message).body
```

### Configuration

If you need to grab only a head part of the message body you need to specify *:only_head* parameter:

```ruby
MailExtract.new(message, :only_head => true)
```

This is extremely useful if you're parsing an email from mobile devices (iphone?) which do not follow the quote pattens.

## Known issues

- Invalid signature patterns (that does not follow --, ___)
- Invalid quote patterns (that does not start with >)

## License

Copyright © 2011 Dan Sosedoff.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
