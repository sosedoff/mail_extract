require 'spec_helper'

describe 'MailExtract::Parser' do
  it 'parses an email' do
    body = parse_fixture('simple.txt')
    body.should == result_fixture('simple.txt')
  end
  
  it 'parses an email with quotes' do
    body = parse_fixture('simple_with_quotes.txt')
    body.should == result_fixture('simple_with_quotes.txt')
  end
  
  it 'parses a reply email with broken authored line' do
    body = parse_fixture('reply_with_quotes.txt')
    body.should == 'This is a first line of the message'
  end
  
  it 'parses a message send via iphone' do
    body = parse_fixture('iphone.txt')
    body.should == 'This is a shit i sent from my iphone'
  end

  it 'parses a reply sent via iphone' do
    body = MailExtract.new(fixture('iphone_with_quotes.txt'), :only_head => true).body
    body.should == 'Primary reply content'
  end
end
