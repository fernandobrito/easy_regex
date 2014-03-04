module EasyRegex

  # Compiles a (postfix) regular expression into a NFA
  class AutomatonConverter

    # Compiles a string representing a regular expression into
    # an automaton.
    #
    # @param postfix [String] the (postfix) regular expression
    def initialize(postfix)
      @postfix = postfix

      # Stack of States
      @stack = []

      # State Accepting
      @state_match = State.new(:match)

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

            s = State.new(:split, frag1.start, frag2.start)

            @stack.push(Fragment.new(s, frag1.out + frag2.out))

          when '?'
            frag = @stack.pop()

            s = State.new(:split, frag.start)

            @stack.push(Fragment.new(s, frag.out + [s]))

          when '*'
            frag = @stack.pop()

            s = State.new(:split, frag.start)
            patch(frag, s)

            @stack.push(Fragment.new(s, [s]))

          when '+'
            frag = @stack.pop()

            s = State.new(:split, frag.start)
            patch(frag, s)

            @stack.push(Fragment.new(frag.start, [s]))

          else
            s = State.new(char)
            @stack.push(Fragment.new(s, [s]))
        end
      end

      frag = @stack.pop

      patch(frag, @state_match)

      @automaton = Automaton.new(frag)
    end

    def result
      @automaton
    end

    # Connect all outs(states with out1 and out2 equal a nil) with state
    def patch(frag, state)
      frag.out.each do |s|
        s.out1 = state if s.out1.nil?

        if s.char == :split
          s.out2 = state if s.out2.nil?
        end
      end
    end

  end
end