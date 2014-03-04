module EasyRegex

  class Regex

    def initialize(re)
      @automaton = Compiler.new(re).result
    end

    def match?(string)
      Matcher.new(@automaton, string).match?
    end

  end

end