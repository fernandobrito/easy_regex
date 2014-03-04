require "easy_regex/version"
require "easy_regex/regex"
require "easy_regex/compiler"
require "easy_regex/matcher"
require "easy_regex/automaton"

require "logger"

module EasyRegex
  @@logger = Logger.new(STDOUT)
  @@logger.level = Logger::DEBUG

  def self.logger
    @@logger
  end
end
