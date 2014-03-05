require 'spec_helper'

describe EasyRegex::Regex do

  describe '::new' do
    pending '#pending'
  end

  describe '#compile' do
    pending '#pending'
  end

  describe '#match?' do

    context 'when expression contains only concatenations' do
      let(:er) { EasyRegex::Regex.new('a') }

      it 'return true' do
        expect(er.match?('a')).to be_true
        expect(er.match?('aa')).to be_true
        expect(er.match?('ba')).to be_true
        expect(er.match?('ab')).to be_true
      end

      it 'return false' do
        expect(er.match?('')).to be_false
        expect(er.match?('b')).to be_false
        expect(er.match?('bb')).to be_false
      end
    end

    context 'when expression contains the operator .' do
      pending '#pending'
    end

    context 'when expression contains the operator +' do
      let(:er) { EasyRegex::Regex.new('a+') }

      it 'return true' do
        expect(er.match?('a')).to be_true
        expect(er.match?('aa')).to be_true
        expect(er.match?('aaa')).to be_true
        expect(er.match?('aaaa')).to be_true
      end

      it 'return false' do
        expect(er.match?('')).to be_false
        expect(er.match?('ab')).to be_false
        expect(er.match?('aba')).to be_false
      end
    end

    context 'when expression contains the operator ?' do
      let(:er) { EasyRegex::Regex.new('a?') }

      it 'return true' do
        expect(er.match?('')).to be_true
        expect(er.match?('a')).to be_true
      end

      it 'return false' do
        expect(er.match?('ab')).to be_false
        expect(er.match?('aba')).to be_false
      end
    end

    context 'when expression contains the operator *' do
      let(:er) { EasyRegex::Regex.new('a*') }

      it 'return true' do
        expect(er.match?('')).to be_true
        expect(er.match?('a')).to be_true
        expect(er.match?('aa')).to be_true
      end

      it 'return false' do
        expect(er.match?('ab')).to be_false
        expect(er.match?('aba')).to be_false
      end
    end

    context 'when expression contains the operator |' do
      pending '#pending'
    end

    context 'when expression contains parentheses' do
      pending '#pending'
    end

  end

  describe '#match?' do
    pending '#pending'
  end


  describe '#eql?' do
    pending '#pending'
  end

  describe '::replace' do
    pending '#pending'
  end

end