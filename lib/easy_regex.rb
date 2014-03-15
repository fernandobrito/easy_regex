require_relative "easy_regex/version"
require_relative "easy_regex/regex"
require_relative "easy_regex/compiler"
require_relative "easy_regex/matcher"
require_relative "easy_regex/automaton"

require "logger"

module EasyRegex
  @@logger = Logger.new(STDOUT)
  @@logger.level = Logger::DEBUG

  def self.logger
    @@logger
  end
end
