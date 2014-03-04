require "easy_regex/compiler/postfix_converter"
require "easy_regex/compiler/automaton_converter"

module EasyRegex

  # Compiles a string representing a regular expression into
  # an automata.
  class Compiler

    # Compiles a string representing a regular expression into
    # an automata.
    #
    # @param re [String] the regular expression
    # @return [NFA] an automata
    def initialize(re)
      @postfix = PostfixConverter.new(re).result
      @automaton = AutomatonConverter.new(@postfix).result
    end
  end
end