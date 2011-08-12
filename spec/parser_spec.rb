require 'spec_helper'

describe 'MailExtract::Parser' do
  it 'parses an email' do
    body = MailExtract.new(fixture('simple.txt')).body
    body.should == result_fixture('simple.txt')
  end
  
  it 'parses an email with quotes' do
    body = MailExtract.new(fixture('simple_with_quotes.txt')).body
    body.should == result_fixture('simple_with_quotes.txt')
  end
  
  it 'parses a reply email with broken authored line' do
    body = MailExtract.new(fixture('reply_with_quotes.txt')).body
    body.should == 'This is a first line of the message'
  end

  it 'parses a reply sent via iphone' do
    body = MailExtract.new(fixture('iphone_with_quotes.txt')).body
    # body.should == 'Primary reply content'
  end
end
