# frozen_string_literal: true

require "async"
require "async/barrier"
require "logger"
module Qravan
  # Database class
  class Rest
    attr_accessor :result, :connection

    def initialize(source)
      @connection = source
    end

    def extract(sql = "select * from smevql1.driverlicenseql3;")
      Console.logger.info "REST EXTRACT: #{sql}"
      internet = Async::HTTP::Internet.new
      barrier = Async::Barrier.new
      time = Time.now
      @result = []
      url = "#{@connection["protocol"]}://#{@connection["host"]}:#{@connection["port"]}/#{@connection["path"]}"
      headers = [%w[accept application/json], %w[content-type application/json]]
      body = [@connection["template"] % { request: sql }]
      barrier.async do
        response = internet.post(url, headers, body)
        response_body = JSON.parse(response.read)
        @result << response_body[@connection["payload-path"]]
      ensure
        response.finish
      end
      barrier.wait
      @result << { time: "REST Duration: #{Time.now - time}s " }
      @result
    end
  end
end
