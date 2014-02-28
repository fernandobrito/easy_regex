module EasyRegex

  # Compiles a (postfix) regular expression into a NFA
  class AutomatonConverter

    # Compiles a string representing a regular expression into
    # an automata.
    #
    # @param re [String] the (postfix) regular expression
    def initialize(postfix)      
      @postfix = postfix

      # Stack of States
      @stack = []

      # State Accepting
      @stateMatch = State.new(:match)

      convert
    end

    def convert
      @postfix.each_char do |char|

        case char
          when '.'
            frag2 = @stack.pop()
            frag1 = @stack.pop()

            patch(frag1, frag2.start)
            
            @stack.push(Fragment.new(frag1.start, frag2.out))
          when '|'
            frag2 = @stack.pop()
            frag1 = @stack.pop()

            s = State.new(:split, frag1, frag2)

            @stack.push(Fragment.new(s, frag1.out + frag2.out))
          when '?'
            frag = @stack.pop()

            s = State.new(:split, frag)

            @stack.push(Fragment.new(s, frag << s))
          when '*'
            frag = @stack.pop()

            s = State.new(:split, frag)
            patch(frag, s)

            @stack.push(Fragment.new(s, s))
          when '+'
            frag = @stack.pop()

            s = State.new(:split, frag)
            patch(frag, s)

            @stack.push(Fragment.new(s, s))
          else
            s = State.new(char)
            @stack.push(Fragment.new(s, s))
        end
      end

      frag = @stack.pop()

      patch(frag, @stateMatch)

      return Automaton.new(frag)
    end #end convert

    ## Connect all outs(states with firstOut and secondOut equal a nil) with state
    def patch( frag, state )
      frag.out.each do |s|
        s.firstOut = state unless s.firstOut.nil?
        s.secondOut = state unless s.secondOut.nil? 
      end
    end
  end
end