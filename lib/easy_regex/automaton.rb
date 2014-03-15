module EasyRegex

  class Automaton
    attr_reader :initial_state

    def initialize(fragment)
      @initial_state = fragment.start
      @cache_string = nil
    end

    def to_s
      if (@cache_string.nil?)
        @cache_string = @initial_state.inspect
      end

      @cache_string
    end
  end

  class State
    attr_accessor :char, :out1, :out2, :id

    @@count = 0

    ## OBS: Optional arguments with default value don't work in
    ## lower ruby versions than 2.0
    def initialize(char, out1 = nil, out2 = nil)
      @char = char
      @out1 = out1
      @out2 = out2

      @@count += 1
      @id = @@count

      @checked = false
    end

    def to_s
      inspect
    end

    def inspect
      output = ""

      if (@char != :split)
        output = "#{@char}[#{@id}]"
      end

      out = "#{@out1}" if ( @out1 && !@out1.checked? && @out2 == nil)
      out = "#{@out1} | #{out2}" if (@out1 && !@out1.checked? && @out2 && !@out2.checked?)

      output << "#{out}" if (@char == :split && out)
      output << " -> (#{out})" if out

      @checked = true
      output
    end

    def checked?
      @checked
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