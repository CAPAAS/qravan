# frozen_string_literal: true

require_relative "qravan/version"
require_relative "qravan/cargo"
require_relative "qravan/source"
require_relative "qravan/model"
require_relative "qravan/query"
require_relative "qravan/credentials"

require "async"
require "async/http/internet"
require "redis"

module Qravan
  class Error < StandardError; end

  def self.root
    File.dirname __dir__
  end

  def self.logs
    File.join root, "logs"
  end

end
