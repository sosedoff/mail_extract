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
end
