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
      elsif (@checked) # :split and checked
        output = "#{@out1.char}[#{@out1.id}]"
      end

      return output if @checked || @char == :match

      @checked = true

      out = "#{@out1}" if ( @out1 && @out2 == nil)
      out = "(#{@out1} | #{@out2})" if (@out1 && @out2)

      output << "#{out}" if (@char == :split && out)
      output << " -> #{out}" if (@char != :split && out)

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