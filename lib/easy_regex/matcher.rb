module EasyRegex
  class Matcher
    def initialize(automaton, string)
      @automaton = automaton
      @string = string
    end

    def match?
      current_list = []
      next_list = []

      add_state(current_list, @automaton.initial_state)

      @string.each_char do |char|
        EasyRegex::logger.debug("Matcher#match?: current: #{current_list} | next: #{next_list}")

        step(current_list, char, next_list)
        EasyRegex::logger.debug("Matcher#match?: next_list #{next_list}")
        current_list, next_list = next_list, current_list
      end

      has_match?(current_list)
    end

  private
    def step(current_list, char, next_list)
      next_list.clear
      current_list.each do |state|
        EasyRegex::logger.debug("Matcher#step: next_list #{next_list}")
        if (state.char == char)
          EasyRegex::logger.debug("Matcher#step: #{char} match #{state.char}")

          add_state(next_list, state.out1)
        else
          EasyRegex::logger.debug("Matcher#step: #{char} does not match #{state.char}")
          EasyRegex::logger.debug("Matcher#step: next_list #{next_list}")
        end
      end
    end

    def add_state(list, state)
      if (state.char == :split)
        add_state(list, state.out1)
        add_state(list, state.out2)
        return
      else
        EasyRegex::logger.debug("Matcher#add_state: adding #{state} to next_list")

        list.push state
      end
    end

    # Iterate over the list and check if it has the match state
    def has_match?(list)
      EasyRegex::logger.debug("Matcher#has_match?: looking for match in #{list}")

      list.each do |state|
        return true if (state.char == :match)
      end

      return false
    end
  end
end