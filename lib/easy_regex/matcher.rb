module EasyRegex
  class Matcher
    def initialize(automaton, string)
      @automaton = automaton
      @string = string
    end

    def match?
      current_list = []
      next_list = []

      current_list = @automaton.initial_state

      @string.each_char do |char|
        step(current_list, char, next_list)
        current_list, next_list = next_list, current_list
      end

      has_match?(current_list)
    end

  private
    def step(cl, c, nl)

    end

    # Iterate over the list and check if it has the match state
    def has_match?(list)
      list.each do |state|
        return true if (state.char == :match)
      end

      return false
    end
  end
end