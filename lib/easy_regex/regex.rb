module EasyRegex

  class Regex

    def initialize(re)
      @re = re
      @automaton = Compiler.new(re).result

      EasyRegex::logger.debug("Regex#new: compiled #{@re} into #{@automaton}")
    end

    def match?(string)
      EasyRegex::logger.debug("Regex#match?: matching #{@re} against #{string}")

      # string.length.times do |i|
      #  return true if Matcher.new(@automaton, string[i..-1]).match?
      # end

      Matcher.new(@automaton, string).match?
    end

  end

end