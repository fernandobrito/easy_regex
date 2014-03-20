require_relative "compiler/postfix_converter"
require_relative "compiler/automaton_converter"

module EasyRegex

  # Compiles a string representing a regular expression into
  # an automaton.
  class Compiler

    # Compiles a string representing a regular expression into
    # an automaton.
    #
    # @param re [String] the regular expression
    # @return [NFA] an automata
    def initialize(re)
      @postfix = PostfixConverter.new(re).result
      @automaton = AutomatonConverter.new(@postfix).result
    end

    # @return [Automaton] compiled automaton.
    def result
      @automaton
    end
  end
end