require 'spec_helper'

describe EasyRegex::Compiler do

  describe '::re2post' do
    def create(re)
      EasyRegex::Compiler.re2post(re)
    end

    it 'does consider |' do
      expect(create('a')).to be_equal('a')
      expect(create('a|b')).to be_equal('ab|')

    end

    it 'does consider unary operands (? * +)' do
      expect(create('a+')).to be_equal('a+')
      expect(create('ab+')).to be_equal('ab+.')
      expect(create('a+b')).to be_equal('a+b.')
    end

    it 'does consider ()' do
      expect(create('(ab)|(ab)')).to be_equal('ab.ab.|')
      expect(create('ab|(ab|aa)')).to be_equal('ab.ab.aa.||')
      expect(create('(ab|ab)|aa')).to be_equal('ab.ab.|aa.|')
    end

    it 'does consider everything' do
      expect(create('ab|ab)|aa+a?(b|a)+a*b+(aa+b*c?)?')).to be_equal('ab.ab.|aa+.a?.ba|+.a*.b+.aa+.b*.c?.?.|')
    end

  end

end

