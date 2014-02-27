module EasyRegex

  # Compiles a (postfix) regular expression into a NFA
  class AutomatonConverter

    # Compiles a string representing a regular expression into
    # an automata.
    #
    # @param re [String] the (postfix) regular expression
    def initialize(postfix)
      @postfix = postfix

      @stack = []


      convert
    end

    def convert
      @postfix.each_char do |char|

        case char
          when '.'
          when '|'
          when '?'
          when '*'
          when '+'
          else
            @stack.push(Fragment.new(state))

        end

      end
    end


    class State

    end

    class Fragment
      def initialize(state)
        @state = state
        # ponteiro?
      end

    end


  end
end