require 'spec_helper'
require File.expand_path(File.join(__FILE__, '../../../', 'lib/bender/command/pair.rb'))

describe Bender::Command::Pair do
  let(:args) { [] }
  subject {Bender::Command::Pair.new(args)}

  describe '#default' do
    let(:hitch_available) { false }
    let(:names) { "Jaymes Waters and Nick Karpenske" }
    let(:emails) { "dev+jaym3s+randland@bendyworks.com" }
    let(:hitch_info) { "#{names} <#{emails}>" }
    let(:hitch_error) { 'error' }
    let(:test_class) { subject.class.any_instance }

    before do
      test_class.stubs(:hitch_available?).returns(hitch_available)
      test_class.stubs(:hitch_names).returns(names)
      test_class.stubs(:hitch_emails).returns(emails)
      test_class.stubs(:hitch_error).returns(hitch_error)
      test_class.stubs(:puts)
    end

    after { subject.default }

    it 'should check to see if Hitch is available' do
      test_class.expects(:hitch_available?)
    end

    context 'when hitch is available' do
      let(:hitch_available) { true }


      it 'should retrieve the git pair names' do
        test_class.expects(:hitch_names)
      end

      it 'should retrieve the git pair emails' do
        test_class.expects(:hitch_emails)
      end

      it 'should print a formatted pair info string' do
        test_class.expects(:puts).with(hitch_info)
      end
    end

    context 'when hitch is not available' do
      let(:hitch_available) { false }

      it 'should not retrieve the git pair names' do
        test_class.expects(:hitch_names).never
      end

      it 'should not retrieve the git pair emails' do
        test_class.expects(:hitch_emails).never
      end

      it 'should print an error message' do
        test_class.expects(:puts).with(hitch_error)
      end
    end
  end
end
