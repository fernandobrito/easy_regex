module EasyRegex

  # Compiles a string representing a regular expression into
  # an automata.
  module Compiler

    # Compiles a string representing a regular expression into
    # an automata.
    #
    # @param re [String] the regular expression
    # @return [NFA] an automata
    def self.compile(re)
      self.re2post(re)
    end

  private
    # Converts a regular expression from infix fom to posfix form
    # Makes it easier to convert it later to an automata.
    def self.re2post(re)
      EasyRegex::logger.debug('#re2post')

      # Creates an stack of Contexts. Used by parenthesis groups to keep track
      # of number of atomics and number of |
      contexts = []
      contexts << Context.new

      # String
      output = String.new

      # iterates over all characters
      re.each_char do |char|
        case char
          when '('
            if (contexts.last.n_atomics > 1)
              contexts.last.n_atomics -= 1
              output += '.'
            end

            contexts.push(Context.new)
          when ')'
            # TODO: check this
            raise ArgumentError, '??' if (contexts.first == contexts.last)
            raise ArgumentError, 'empty parenthesis group' if (contexts.last.n_atomics == 0)

            contexts.last.n_atomics -= 1
            while (contexts.last.n_atomics > 0)
              output += '.'
              contexts.last.n_atomics -= 1
            end

            while (contexts.last.n_or > 0)
              output += '|'
              contexts.last.n_or -= 1
            end

            contexts.pop
            contexts.last.n_atomics += 1
          when '|'
            raise ArgumentError, '| found, but no literals before it' if (contexts.last.n_atomics == 0)

            contexts.last.n_atomics -= 1
            while (contexts.last.n_atomics > 0)
              output += '.'
              contexts.last.n_atomics -= 1
            end

            contexts.last.n_or += 1
          when '*', '+', '?'
            raise ArgumentError, "#{char} found, but no literals before it" if (contexts.last.n_atomics == 0)

            output += char
          else # literals
            if (contexts.last.n_atomics > 1)
              contexts.last.n_atomics -= 1
              output += '.'
            end

            output += char
            contexts.last.n_atomics += 1
        end
      end

      contexts.last.n_atomics -= 1
      while (contexts.last.n_atomics > 0)
        output += '.'
        contexts.last.n_atomics -= 1
      end

      contexts.last.n_or.times do
        output += '|'
      end

      output
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