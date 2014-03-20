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
      let(:er2) { EasyRegex::Regex.new('aa') }
      let(:er3) { EasyRegex::Regex.new('ba') }
      let(:er4) { EasyRegex::Regex.new('ab') }

      it 'return true' do
        expect(er.match?('a')).to be_true
        expect(er2.match?('aa')).to be_true
        expect(er3.match?('ba')).to be_true
        expect(er4.match?('ab')).to be_true
      end

      it 'return false' do
        expect(er.match?('')).to be_false
        expect(er2.match?('ab')).to be_false
        expect(er3.match?('bb')).to be_false
        expect(er4.match?('bb')).to be_false
      end
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
      let(:er) { EasyRegex::Regex.new('a|b') }
      let(:er2) { EasyRegex::Regex.new('ferramenta|chave') }

      it 'return true' do
        expect(er.match?('a')).to be_true
        expect(er.match?('b')).to be_true
        expect(er2.match?('ferramenta')).to be_true
        expect(er2.match?('chave')).to be_true
      end

      it 'return false' do
        expect(er2.match?('chve')).to be_false
        expect(er2.match?('ferramente')).to be_false
      end
    end

    context 'when expression contains parentheses' do
      pending '#pending'
    end

  end

  describe '#eql?' do
    pending '#pending'
  end

end