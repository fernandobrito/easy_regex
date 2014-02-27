module EasyRegex

  # Converts a regular expression from infix fom to posfix form
  class PostfixConverter

    # Compiles a string representing a regular expression into
    # an automata.
    #
    # @param re [String] the regular expression

    def initialize(re)
      # Debug
      EasyRegex::logger.debug("Compiler#re2post: converting #{re} to postfix form")

      # Saves the original regular expression string
      @re = re

      # Creates an stack of Contexts. Used by parenthesis groups to keep track
      # of number of atomics and number of |
      @contexts = []
      @contexts << Context.new

      # Creates the output
      @output = String.new

      # Method to actually convert it
      convert

      # Debug
      EasyRegex::logger.debug("Compiler#re2post: converted #{re} to #{@output}")
    end

    # @return [String] regular expression in postfix form
    def result
      @output
    end

    def convert
      # iterates over all characters
      @re.each_char do |char|
        case char

          when '('
            insert_one_concatenation_symbol

            @contexts.push(Context.new)

          when ')'
            raise ArgumentError, 'closing never opened parenthesis' if (@contexts.first == context)
            raise ArgumentError, 'empty parenthesis group' if (context.n_atomics == 0)

            flush_concatenation_symbol
            insert_or

            @contexts.pop
            context.n_atomics += 1

          when '|'
            raise ArgumentError, '| found, but no literals before it' if (context.n_atomics == 0)

            flush_concatenation_symbol

            context.n_or += 1

          when '*', '+', '?'
            raise ArgumentError, "#{char} found, but no literals before it" if (context.n_atomics == 0)

            @output += char

          else
            insert_one_concatenation_symbol

            @output += char
            context.n_atomics += 1
        end
      end

      raise ArgumentError, 'parenthesis group not closed' if (@contexts.first != context)

      flush_concatenation_symbol

      context.n_or.times do
        @output += '|'
      end
    end

  private
    def insert_one_concatenation_symbol
      if (context.n_atomics > 1)
        context.n_atomics -= 1
        @output += '.'
      end
    end

    def context
      @contexts.last
    end

    def insert_or
      while (context.n_or > 0)
        @output += '|'
        context.n_or -= 1
      end
    end

    def flush_concatenation_symbol
      context.n_atomics -= 1

      while (context.n_atomics > 0)
        @output += '.'
        context.n_atomics -= 1
      end

    end
  end

  class Context
    attr_accessor :n_atomics, :n_or

    def initialize
      @n_atomics = 0
      @n_or = 0
    end
  end
end