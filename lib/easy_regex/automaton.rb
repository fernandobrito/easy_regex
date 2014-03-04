module EasyRegex

  class Automaton
    def initialize(fragment)
      @initial_state = fragment.start
    end
  end

  class State
    attr_accessor :char, :out1, :out2

    ## OBS: Optional arguments with default value don't work in 
    ## lower ruby versions than 2.0
    def initialize(char, out1 = nil, out2 = nil)
      @char = char
      @out1 = out1
      @out2 = out2
    end
  end

  class Fragment
    attr_accessor :start, :out

    def initialize(start, out)
      @start = start
      @out = out
    end
  end

end