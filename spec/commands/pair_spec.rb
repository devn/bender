require 'spec_helper'
require File.expand_path(File.join(__FILE__, '../../../', 'lib/bender/command/pair.rb'))

describe Bender::Command::Pair do
  let(:args) { [] }
  subject { Bender::Command::Pair.new(args) }

  before do
    subject.instance_variable_set(:@pair_class, stub('Hitch', :name => 'Hitch'))
  end

  describe 'actions' do
    its(:class) { should respond_to(:help_summary) }

    it { should respond_to(:default) }
  end

  describe '#default' do
    let(:test_class) { subject.class.any_instance }
    let(:hitch_available) { false }
    let(:names) { "Jaymes Waters and Nick Karpenske" }
    let(:emails) { "dev+jaym3s+randland@bendyworks.com" }
    let(:hitch_info) { "#{names} <#{emails}>" }
    let(:hitch_error) { 'error' }

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

    context 'when hitch is not available' do
      let(:hitch_available) { false }

      it 'should print an error message' do
        test_class.expects(:puts).with(hitch_error)
      end
    end

    context 'when hitch is available' do
      let(:hitch_available) { true }

      context 'and no parameters are given' do
        let(:args) { [] }
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

      context 'and the -u parameter is given' do
        let(:args) { %w(-u) }

        it 'should unpair' do
          test_class.expects(:unpair)
        end
      end

      context 'and name parameters are given' do
        let(:args) { ["jaym3s","randland"] }

        it 'should pair the two users' do
          test_class.expects(:pair).with(args)
        end
      end
    end
  end
end
