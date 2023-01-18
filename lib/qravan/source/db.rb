# frozen_string_literal: true

require "async"
require "sequel"
require "logger"
module Qravan
  # Database class
  class Db
    attr_accessor :result, :connection

    def initialize(source)
      @connection = Sequel.connect(adapter: source["adapter"],
                                   user: source["user"],
                                   password: source["password"],
                                   host: source["host"],
                                   port: source["port"],
                                   database: source["database"],
                                   max_connections: source["max_connections"],
                                   logger: Logger.new("logs/db.log"))

    end

    def extract(sql)
      Console.logger.info "DB EXTRACT: #{sql}"
      @result = []
      time = Time.now
      @connection[sql].each do |row|
        @result << row
      end
      total = Time.now - time
      @result << { time: "DB Duration: #{Time.now - time}s" }
      @result
    end
  end
end
