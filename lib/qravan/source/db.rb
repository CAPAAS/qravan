# frozen_string_literal: true

require "async"
require "sequel"
require "logger"
module Qravan
  # Database class
  class Db
    attr_accessor :connection

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
      result = []
      @connection[sql].each do |row|
        result << row
      end
      result
    end
  end
end
