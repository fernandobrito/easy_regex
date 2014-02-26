require "easy_regex/version"
require "easy_regex/regex"
require "easy_regex/compiler"

require "logger"

module EasyRegex
  @@logger = Logger.new(STDOUT)
  @@logger.level = Logger::INFO

  def self.logger
    @@logger
  end
end
