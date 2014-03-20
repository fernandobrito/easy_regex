module EasyRegex

  # Represents a NFA.
  #
  # In practice, it is just a pointer (initial_state) to a fragment.
  class Automaton
    attr_reader :initial_state

    # @param fragment [Fragment] initial fragment of the NFA
    def initialize(fragment)
      @initial_state = fragment.start
      @cache_string = nil
    end

    # @return [String] textual representation of the automaton
    # it delegates to the method 'inspect' in the fragment and
    # keeps a cache of it.
    def to_s
      if (@cache_string.nil?)
        @cache_string = @initial_state.inspect
      end

      @cache_string
    end
  end


  # Represents a state of an NFA.
  #
  # It holds a 'char' and it points to at most 2 other states.
  class State
    attr_accessor :char, :out1, :out2, :id

    # Shared counter used to assign unique identifiers to all states
    @@count = 0

    # @param char [String]
    # @param out1 [State]
    # @param out2 [State]
    def initialize(char, out1 = nil, out2 = nil)
      @char = char
      @out1 = out1
      @out2 = out2

      @@count += 1
      @id = @@count

      @checked = false
    end

    # Delegates to #inspect
    def to_s
      inspect
    end

    # @return [String] textual representation of the state
    # Calls #to_s (inspect) of out1 and out2, so it has a recursive behaviour
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

  protected
    def checked?
      @checked
    end
  end

  # Abstract representation that encapsulates an State and its outgoing arrows
  class Fragment
    attr_accessor :start, :out

    def initialize(start, out)
      @start = start
      @out = out
    end
  end

end