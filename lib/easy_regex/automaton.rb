module EasyRegex
  class Automaton

    def initialize( frag )
      @initialState = frag.start
    end

  end

  class State
    attr_accessor :char, :firstOut, :secondOut

    ## OBS: Optional arguments with default value don't work in 
    ## lower ruby versions than 2.0
    def initialize( char, firstOut = nil, secondOut = nil )
      @char = char
      @firstOut = firstOut
      @secondOut = secondOut
    end
  end

  class Fragment
    attr_accessor :start, :out

    def initialize( start, out )
      @start = start
      @out = out
    end

  end

end