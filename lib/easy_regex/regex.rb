module EasyRegex

  # Main class of the library and the only one that needs to be used from
  # an user perspective.
  #
  # It takes an string representing the regular expression in its constructor
  # and compiles this expression into an NFA, which is kept on cache.
  #
  # Through the method #match?, one can pass a string as argument and see
  # to see if the regular expression matches the string or not.
  #
  # In case one needs an new regular expression, a new object must be created.
  class Regex

    # @param re [String] string representing the regular expression.
    def initialize(re)
      @re = re
      @automaton = Compiler.new(re).result

      EasyRegex::logger.debug("Regex#new: compiled #{@re} into #{@automaton}")
    end

    # @param string [String] string to be matched against the regular expression.
    # @return [Boolean] whether the regular expression matches the string or not.
    def match?(string)
      EasyRegex::logger.debug("Regex#match?: matching #{@re} against #{string}")

      Matcher.new(@automaton, string).match?
    end

    # @return [String] text representation of the automaton. Delegates to [Automaton].
    def print_automaton
      @automaton.to_s
    end

  end

end