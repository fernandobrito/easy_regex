require 'spec_helper'

describe EasyRegex::PostfixConverter do

  describe '::new' do
    def create(re)
      EasyRegex::PostfixConverter.new(re).result
    end

    it 'does consider |' do
      expect(create('a')).to eq('a')
      expect(create('a|b')).to eq('ab|')
    end

    it 'does consider unary operands (? * +)' do
      expect(create('a+')).to eq('a+')
      expect(create('ab+')).to eq('ab+.')
      expect(create('a+b')).to eq('a+b.')
    end

    it 'does consider ()' do
      expect(create('(ab)|(ab)')).to eq('ab.ab.|')
      expect(create('ab|(ab|aa)')).to eq('ab.ab.aa.||')
      expect(create('(ab|ab)|aa')).to eq('ab.ab.|aa.|')
    end

    it 'does consider everything' do
      expect(create('(ab|ab)|aa+a?(b|a)+a*b+(aa+b*c?)?')).to eq('ab.ab.|aa+.a?.ba|+.a*.b+.aa+.b*.c?.?.|')
    end

  end

end

