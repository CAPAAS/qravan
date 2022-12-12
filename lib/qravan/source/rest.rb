# frozen_string_literal: true

require "async"
require "async/barrier"
require "logger"
module Qravan
  # Database class
  class Rest
    attr_accessor :result

    def initialize(source)
      @connection = source
    end

    def extract(sql = "select * from smevql1.driverlicenseql3;")
      Console.logger.info "REST EXTRACT: #{sql}"
      internet = Async::HTTP::Internet.new
      barrier = Async::Barrier.new
      time = Time.now
      requests = 0
      @result = []
      url = "http://#{@connection["host"]}:#{@connection["port"]}/#{@connection["path"]}"
      body = [@connection["template"] % { request: sql }]
      Console.logger.info body
      headers = [%w[accept application/json], %w[content-type application/json]]
      barrier.async do
        Console.logger.info "POST: #{url}"
        begin
          response = internet.post(url, headers, body)
          body = JSON.parse(response.read)
          @result << body[@connection["payload-path"]]
          requests += 1
        ensure
          response.finish
        end
        Console.logger.info "DONE: #{url}"
      end
      barrier.wait
      total = Time.now - time
      @result << { time: "Duration: #{Time.now - time}s for #{requests} (RPS: #{(requests / total).to_i} r/s)" }
      @result
    end
  end
end
