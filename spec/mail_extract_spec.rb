require 'spec_helper'

describe 'MailExtract' do
  it 'parses an email via shortcuts' do
    MailExtract.new(fixture('simple.txt')).body.should == result_fixture('simple.txt')
    MailExtract.parse(fixture('simple.txt')).should == result_fixture('simple.txt')
  end
end
